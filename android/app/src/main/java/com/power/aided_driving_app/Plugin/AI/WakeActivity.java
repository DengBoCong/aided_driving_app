package com.power.aided_driving_app.Plugin.AI;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.telephony.SmsManager;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.animation.Animation;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.TextView;
import android.widget.Toast;

import com.iflytek.cloud.ErrorCode;
import com.iflytek.cloud.InitListener;
import com.iflytek.cloud.RequestListener;
import com.iflytek.cloud.SpeechConstant;
import com.iflytek.cloud.SpeechError;
import com.iflytek.cloud.SpeechEvent;
import com.iflytek.cloud.SpeechSynthesizer;
import com.iflytek.cloud.SynthesizerListener;
import com.iflytek.cloud.VoiceWakeuper;
import com.iflytek.cloud.WakeuperListener;
import com.iflytek.cloud.WakeuperResult;
import com.iflytek.cloud.util.ResourceUtil;
import com.iflytek.cloud.util.ResourceUtil.RESOURCE_TYPE;
import com.power.aided_driving_app.R;
import com.wang.avi.AVLoadingIndicatorView;

import java.util.ArrayList;

import androidx.core.app.ActivityCompat;
import dmax.dialog.SpotsDialog;

public class WakeActivity extends Activity{
	private String TAG = "ivw";
	private Toast mToast;
	/*private TextView textView;*/
	// 语音唤醒对象
	private VoiceWakeuper mIvw;
	// 唤醒结果内容
	private String resultString;
	private AVLoadingIndicatorView avi;
	
	// 设置门限值 ： 门限值越低越容易被唤醒
	private TextView tvThresh;
	private SeekBar seekbarThresh;
	private final static int MAX = 3000;
	private final static int MIN = 0;
	private int curThresh = 1450;
	private String threshStr = "";
	private String keep_alive = "1";
    private String ivwNetMode = "0";
    private SpeechSynthesizer mTts;

	// 引擎类型
	private String mEngineType = SpeechConstant.TYPE_CLOUD;
	// 默认云端发音人
	public static String voicerCloud="xiaoyan";

	//缓冲进度
	private int mPercentForBuffering = 0;
	//播放进度
	private int mPercentForPlaying = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.wake_activity);
        requestPermissions();

		// 初始化合成对象
		mTts = SpeechSynthesizer.createSynthesizer(this, mTtsInitListener);
		if( null == mTts ){
			// 创建单例失败，与 21001 错误为同样原因，参考 http://bbs.xfyun.cn/forum.php?mod=viewthread&tid=9688
			this.showTip( "创建对象失败，请确认 libmsc.so 放置正确，\n 且有调用 createUtility 进行初始化" );
			return;
		}

        // 设置参数
        setParam();
        int code = mTts.startSpeaking("已进入驾驶模式，小沫时刻为你服务", mTtsListener);
        if (code != ErrorCode.SUCCESS) {
            showTip("语音合成失败,错误码: " + code);
        }

		initUi();
		// 初始化唤醒对象
		mIvw = VoiceWakeuper.createWakeuper(this, null);

		avi= (AVLoadingIndicatorView) findViewById(R.id.avi);
		avi.setIndicator("BallScaleMultipleIndicator");
		avi.setIndicatorColor(Color.argb(5,67,183,255));
	}

	@SuppressLint("ShowToast")
	private void initUi() {
		mToast = Toast.makeText(this, "", Toast.LENGTH_SHORT);
		/*textView = (TextView) findViewById(R.id.txt_show_msg);*/
		tvThresh = (TextView)findViewById(R.id.txt_thresh);
		seekbarThresh = (SeekBar)findViewById(R.id.seekBar_thresh);
		seekbarThresh.setMax(MAX - MIN);
		seekbarThresh.setProgress(curThresh);
		tvThresh.setText(threshStr);
		setRadioEnable(false);
		seekbarThresh.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {

			@Override
			public void onStopTrackingTouch(SeekBar arg0) {
			}

			@Override
			public void onStartTrackingTouch(SeekBar arg0) {
			}

			@Override
			public void onProgressChanged(SeekBar arg0, int arg1, boolean arg2) {
				curThresh = seekbarThresh.getProgress() + MIN;
				tvThresh.setText(threshStr);
			}
		});
		
		RadioGroup group = (RadioGroup) findViewById(R.id.ivw_net_mode);
		group.setOnCheckedChangeListener(new OnCheckedChangeListener() {
			@Override
			public void onCheckedChanged(RadioGroup arg0, int arg1) {
				/**
				 * 闭环优化网络模式有三种：
				 * 模式0：关闭闭环优化功能
				 * 
				 * 模式1：开启闭环优化功能，允许上传优化数据。需开发者自行管理优化资源。
				 * sdk提供相应的查询和下载接口，请开发者参考API文档，具体使用请参考本示例
				 * queryResource及downloadResource方法；
				 * 
				 * 模式2：开启闭环优化功能，允许上传优化数据及启动唤醒时进行资源查询下载；
				 * 本示例为方便开发者使用仅展示模式0和模式2；
				 */
				switch (arg1) {
				case R.id.mode_close:
					ivwNetMode = "0";
					break;
				case R.id.mode_open:
					ivwNetMode = "1";
					break;
				default:
					break;
				}
			}
		});

		//非空判断，防止因空指针使程序崩溃
		mIvw = VoiceWakeuper.getWakeuper();
		if(mIvw != null) {
			setRadioEnable(false);
			resultString = "";
			/*textView.setText(resultString);*/

			// 清空参数
			mIvw.setParameter(SpeechConstant.PARAMS, null);
			// 唤醒门限值，根据资源携带的唤醒词个数按照“id:门限;id:门限”的格式传入
			mIvw.setParameter(SpeechConstant.IVW_THRESHOLD, "0:"+ curThresh);
			// 设置唤醒模式
			mIvw.setParameter(SpeechConstant.IVW_SST, "wakeup");
			// 设置持续进行唤醒
			mIvw.setParameter(SpeechConstant.KEEP_ALIVE, keep_alive);
			// 设置闭环优化网络模式
			mIvw.setParameter(SpeechConstant.IVW_NET_MODE, ivwNetMode);
			// 设置唤醒资源路径
			mIvw.setParameter(SpeechConstant.IVW_RES_PATH, getResource());
			// 设置唤醒录音保存路径，保存最近一分钟的音频
			mIvw.setParameter( SpeechConstant.IVW_AUDIO_PATH, Environment.getExternalStorageDirectory().getPath()+"/msc/ivw.wav" );
			mIvw.setParameter( SpeechConstant.AUDIO_FORMAT, "wav" );
			// 如有需要，设置 NOTIFY_RECORD_DATA 以实时通过 onEvent 返回录音音频流字节
			//mIvw.setParameter( SpeechConstant.NOTIFY_RECORD_DATA, "1" );

			// 启动唤醒
			mIvw.startListening(mWakeuperListener);
		} else {
			showTip("唤醒未初始化");
		}

	}
	
	/**
	 * 查询闭环优化唤醒资源
	 * 请在闭环优化网络模式1或者模式2使用
	 */
	public void queryResource() {
		int ret = mIvw.queryResource(getResource(), requestListener);
		showTip("updateResource ret:"+ret);
	}


	// 查询资源请求回调监听
	private RequestListener requestListener = new RequestListener() {
		@Override
		public void onEvent(int eventType, Bundle params) {
			// 以下代码用于获取查询会话id，当业务出错时将会话id提供给技术支持人员，可用于查询会话日志，定位出错原因
			//if(SpeechEvent.EVENT_SESSION_ID == eventType) {
			// 	Log.d(TAG, "sid:"+params.getString(SpeechEvent.KEY_EVENT_SESSION_ID));
			//}
		}
		
		@Override
		public void onCompleted(SpeechError error) {
			if(error != null) {
				Log.d(TAG, "error:"+error.getErrorCode());
				showTip(error.getPlainDescription(true));
			}
		}
		
		@Override
		public void onBufferReceived(byte[] buffer) {
			try {
				String resultInfo = new String(buffer, "utf-8");
				Log.d(TAG, "resultInfo:"+resultInfo);
				
				JSONTokener tokener = new JSONTokener(resultInfo);
				JSONObject object = new JSONObject(tokener);

				int ret = object.getInt("ret");
				if(ret == 0) {
					String uri = object.getString("dlurl");
					String md5 = object.getString("md5");
					Log.d(TAG,"uri:"+uri);
					Log.d(TAG,"md5:"+md5);
					showTip("请求成功");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	};


	private WakeuperListener mWakeuperListener = new WakeuperListener() {

		@Override
		public void onResult(WakeuperResult result) {
			Log.d(TAG, "onResult");
			if(!"1".equalsIgnoreCase(keep_alive)) {
				setRadioEnable(true);
			}
			try {
				String text = result.getResultString();
				JSONObject object;
				object = new JSONObject(text);
				StringBuffer buffer = new StringBuffer();
				buffer.append("【RAW】 "+text);
				buffer.append("\n");
				buffer.append("【操作类型】"+ object.optString("sst"));
				buffer.append("\n");
				buffer.append("【唤醒词id】"+ object.optString("id"));
				buffer.append("\n");
				buffer.append("【得分】" + object.optString("score"));
				buffer.append("\n");
				buffer.append("【前端点】" + object.optString("bos"));
				buffer.append("\n");
				buffer.append("【尾端点】" + object.optString("eos"));
				resultString =buffer.toString();

				if(object.optString("id").equals("0")){
					startCheckDriving();
				}else if(object.optString("id").equals("1")){
				    startCheckHealth();
                }else if(object.optString("id").equals("2")){
				    startAnswer();
                }else if(object.optString("id").equals("3")){
				    startHelp();
                }else if(object.optString("id").equals("4")){
				    startCanDriving();
                }else if(object.optString("id").equals("5")){
					startZaiMa();
				}else{
				    startReport();
                }

			} catch (JSONException e) {
				resultString = "结果解析出错";
				e.printStackTrace();
			}
			/*textView.setText(resultString);*/
		}

		private void startCheckDriving(){
			int code = mTts.startSpeaking("正在收集实时驾驶数据，请稍后", mTtsListener);
			if(code != ErrorCode.SUCCESS){
				showTip("语音合成失败，错误码: " + code);
			}

			AlertDialog spotsDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("正在检测驾驶数据...")
					.build();

			spotsDialog.show();

			Handler handler = new Handler();
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("驾驶数据收集完毕，车速13，车道正常，后方有来车，无红绿灯路口", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					spotsDialog.dismiss();
				}
			};
			handler.postDelayed(runnable, 3000);

		}

		private void startCheckHealth(){
		    int code = mTts.startSpeaking("正在收集实时健康数据，请稍后", mTtsListener);
		    if(code != ErrorCode.SUCCESS){
		        showTip("语音合成失败，错误码: " + code);
            }

			AlertDialog alertDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("正在检测健康数据...")
					.build();

		    alertDialog.show();

		    Handler handler = new Handler();
		    Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("健康数据收集完毕，心率73，血压121/79，体温37.7℃，血脂4.9，血氧饱和度90%", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					alertDialog.dismiss();
				}
			};
			handler.postDelayed(runnable, 3000);

        }

        private void startAnswer(){
            int code = mTts.startSpeaking("正在紧急分析驾驶及健康数据", mTtsListener);
            if(code != ErrorCode.SUCCESS){
                showTip("语音合成失败，错误码: " + code);
            }

			AlertDialog alertDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("数据分析中...")
					.build();

			alertDialog.show();

			Handler handler = new Handler();
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("分析完毕，检测到你处于驾驶中，建议靠边停车，你的基本指标数据正常，数据已打包发送至医师中心进行人工分析", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					alertDialog.dismiss();

					PendingIntent pendingIntent = PendingIntent.getActivity(WakeActivity.this, 0, new Intent(), 0);
					SmsManager sms = SmsManager.getDefault();
					ArrayList<String> texts = sms.divideMessage("姓名：林沫\n年龄：20\n用户定位：湖北省武汉市洪山区珞喻路1037号附近路段\n用户历史数据报告编码：201906160098LINMO\n是否存在病史(在线报告编码)：Afo39sAL1212\n智能数据分析警告程度：轻度\n基本健康指标数据：心率_97次/分  血压_121/79mmHg  体温_37.7℃  血脂_4.9mmol/L  血氧饱和度_90%\n基本驾驶指标数据：车速_13km/h  车体传感器设备状况_正常");
					for(String text : texts){
						sms.sendTextMessage("15179284059", null,
								text,
								pendingIntent, null);
					}
				}
			};
			handler.postDelayed(runnable, 5000);
        }

        private void startHelp(){
		    int code = mTts.startSpeaking("拨打紧急联系人中", mTtsListener);
            if(code != ErrorCode.SUCCESS){
                showTip("语音合成失败，错误码: " + code);
            }

			AlertDialog alertDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("正在采取紧急措施...")
					.build();

			alertDialog.show();

			Handler handler = new Handler();
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("分析完毕，数据已打包发送至医师中心", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					alertDialog.dismiss();

					Intent intent = new Intent(Intent.ACTION_CALL);
					Uri data = Uri.parse("tel:" + "15079065240");
					intent.setData(data);
					startActivity(intent);
				}
			};
			handler.postDelayed(runnable, 9000);
        }

        private void startCanDriving(){
            int code = mTts.startSpeaking("正在为你分析车况及健康状况", mTtsListener);
            if(code != ErrorCode.SUCCESS){
                showTip("语音合成失败，错误码: " + code);
            }

			AlertDialog alertDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("正在分析...")
					.build();

			alertDialog.show();

			Handler handler = new Handler();
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("外接传感器连接正常，基本健康指标正常", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					alertDialog.dismiss();
				}
			};
			handler.postDelayed(runnable, 3000);
        }

		private void startZaiMa(){
			int code = mTts.startSpeaking("在，有什么吩咐嘛", mTtsListener);
			if (code != ErrorCode.SUCCESS) {
				showTip("语音合成失败,错误码: " + code);
			}
		}

		private void startReport(){
            int code = mTts.startSpeaking("周报获取中", mTtsListener);
            if (code != ErrorCode.SUCCESS) {
                showTip("语音合成失败,错误码: " + code);
            }

			AlertDialog alertDialog = new SpotsDialog.Builder()
					.setContext(WakeActivity.this)
					.setMessage("周报获取中...")
					.build();

			alertDialog.show();

			Handler handler = new Handler();
			Runnable runnable = new Runnable() {
				@Override
				public void run() {
					int code = mTts.startSpeaking("正在生成智能周报", mTtsListener);
					if(code != ErrorCode.SUCCESS){
						showTip("语音合成失败，错误码: " + code);
					}
					alertDialog.dismiss();
					new SpotsDialog.Builder()
							.setContext(WakeActivity.this)
							.setMessage("周报获取中...")
							.setCancelable(true)
							.build()
							.show();
				}
			};
			handler.postDelayed(runnable, 3000);
        }

		@Override
		public void onError(SpeechError error) {
			showTip(error.getPlainDescription(true));
			setRadioEnable(true);
		}

		@Override
		public void onBeginOfSpeech() {
		}

		@Override
		public void onEvent(int eventType, int isLast, int arg2, Bundle obj) {
			switch( eventType ){
			// EVENT_RECORD_DATA 事件仅在 NOTIFY_RECORD_DATA 参数值为 真 时返回
			case SpeechEvent.EVENT_RECORD_DATA:
				final byte[] audio = obj.getByteArray( SpeechEvent.KEY_EVENT_RECORD_DATA );
				Log.i( TAG, "ivw audio length: "+audio.length );
				break;
			}
		}

		@Override
		public void onVolumeChanged(int volume) {
			
		}
	};
	
	@Override
	protected void onDestroy() {
		super.onDestroy();
		Log.d(TAG, "onDestroy WakeDemo");
		// 销毁合成对象
		mIvw.stopListening();
		mIvw = VoiceWakeuper.getWakeuper();
		if (mIvw != null) {
			mIvw.destroy();
		}
	}
	
	private String getResource() {
		final String resPath = ResourceUtil.generateResourcePath(WakeActivity.this, RESOURCE_TYPE.assets, "ivw/"+getString(R.string.app_id)+".jet");
		Log.d( TAG, "resPath: "+resPath );
		return resPath;
	}

	private void showTip(final String str) {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				mToast.setText(str);
				mToast.show();
			}
		});
	}
	
	private void setRadioEnable(final boolean enabled) {
		runOnUiThread(new Runnable() {
			@Override
			public void run() {
				findViewById(R.id.ivw_net_mode).setEnabled(enabled);
				findViewById(R.id.btn_start).setEnabled(enabled);
				findViewById(R.id.btn_stop).setEnabled(enabled);
				findViewById(R.id.seekBar_thresh).setEnabled(enabled);
			}
		});
	}

	/**
	 * 初始化监听。
	 */
	private InitListener mTtsInitListener = new InitListener() {
		@Override
		public void onInit(int code) {
			Log.d(TAG, "InitListener init() code = " + code);
			if (code != ErrorCode.SUCCESS) {
				showTip("初始化失败,错误码："+code);
			} else {
				// 初始化成功，之后可以调用startSpeaking方法
				// 注：有的开发者在onCreate方法中创建完合成对象之后马上就调用startSpeaking进行合成，
				// 正确的做法是将onCreate中的startSpeaking调用移至这里
			}
		}
	};

	/**
	 * 参数设置
	 */
	private void setParam(){
		// 清空参数
		mTts.setParameter(SpeechConstant.PARAMS, null);
		//设置合成
		/*if(mEngineType.equals(SpeechConstant.TYPE_CLOUD))
		{*/
		//设置使用云端引擎
		mTts.setParameter(SpeechConstant.ENGINE_TYPE, SpeechConstant.TYPE_CLOUD);
		//设置发音人
		mTts.setParameter(SpeechConstant.VOICE_NAME, voicerCloud);
		/*}else {
			//设置使用本地引擎
			mTts.setParameter(SpeechConstant.ENGINE_TYPE, SpeechConstant.TYPE_LOCAL);
			//设置发音人资源路径
			mTts.setParameter(ResourceUtil.TTS_RES_PATH,getResourcePath());
			//设置发音人
			mTts.setParameter(SpeechConstant.VOICE_NAME,voicerLocal);
		}*/
		//mTts.setParameter(SpeechConstant.TTS_DATA_NOTIFY,"1");//支持实时音频流抛出，仅在synthesizeToUri条件下支持
		//设置合成语速
		mTts.setParameter(SpeechConstant.SPEED, "50");
		//设置合成音调
		mTts.setParameter(SpeechConstant.PITCH, "50");
		//设置合成音量
		mTts.setParameter(SpeechConstant.VOLUME, "50");
		//设置播放器音频流类型
		mTts.setParameter(SpeechConstant.STREAM_TYPE, "3");

		// 设置播放合成音频打断音乐播放，默认为true
		mTts.setParameter(SpeechConstant.KEY_REQUEST_FOCUS, "true");

		// 设置音频保存路径，保存音频格式支持pcm、wav，设置路径为sd卡请注意WRITE_EXTERNAL_STORAGE权限
		mTts.setParameter(SpeechConstant.AUDIO_FORMAT, "wav");
		mTts.setParameter(SpeechConstant.TTS_AUDIO_PATH, Environment.getExternalStorageDirectory()+"/msc/tts.wav");
	}

	/**
	 * 合成回调监听。
	 */
	private SynthesizerListener mTtsListener = new SynthesizerListener() {

		@Override
		public void onSpeakBegin() {
			showTip("开始播放");
		}

		@Override
		public void onSpeakPaused() {
			showTip("暂停播放");
		}

		@Override
		public void onSpeakResumed() {
			showTip("继续播放");
		}

		@Override
		public void onBufferProgress(int percent, int beginPos, int endPos,
									 String info) {
			// 合成进度
			mPercentForBuffering = percent;
			showTip(String.format(getString(R.string.tts_toast_format),
					mPercentForBuffering, mPercentForPlaying));
		}

		@Override
		public void onSpeakProgress(int percent, int beginPos, int endPos) {
			// 播放进度
			mPercentForPlaying = percent;
			showTip(String.format(getString(R.string.tts_toast_format),
					mPercentForBuffering, mPercentForPlaying));
		}

		@Override
		public void onCompleted(SpeechError error) {
			if (error == null) {
				showTip("播放完成");
			} else if (error != null) {
				showTip(error.getPlainDescription(true));
			}
		}

		@Override
		public void onEvent(int eventType, int arg1, int arg2, Bundle obj) {
			// 以下代码用于获取与云端的会话id，当业务出错时将会话id提供给技术支持人员，可用于查询会话日志，定位出错原因
			// 若使用本地能力，会话id为null
			//	if (SpeechEvent.EVENT_SESSION_ID == eventType) {
			//		String sid = obj.getString(SpeechEvent.KEY_EVENT_SESSION_ID);
			//		Log.d(TAG, "session id =" + sid);
			//	}

			//实时音频流输出参考
			/*if (SpeechEvent.EVENT_TTS_BUFFER == eventType) {
				byte[] buf = obj.getByteArray(SpeechEvent.KEY_EVENT_TTS_BUFFER);
				Log.e("MscSpeechLog", "buf is =" + buf);
			}*/
		}
	};

    private void requestPermissions(){
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                int permission = ActivityCompat.checkSelfPermission(this,
                        Manifest.permission.WRITE_EXTERNAL_STORAGE);
                if(permission!= PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(this,new String[] {
                            Manifest.permission.WRITE_EXTERNAL_STORAGE,
                            Manifest.permission.LOCATION_HARDWARE,Manifest.permission.READ_PHONE_STATE,
                            Manifest.permission.WRITE_SETTINGS,Manifest.permission.READ_EXTERNAL_STORAGE,
                            Manifest.permission.RECORD_AUDIO,Manifest.permission.READ_CONTACTS,Manifest.permission.SEND_SMS,
                            Manifest.permission.READ_SMS,Manifest.permission.RECEIVE_SMS,Manifest.permission.CALL_PHONE},0x0010);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
package com.power.aided_driving_app.Plugin.AI;

import com.iflytek.cloud.SpeechConstant;
import com.iflytek.cloud.SpeechUtility;
import com.iflytek.cloud.VoiceWakeuper;
import com.power.aided_driving_app.R;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import androidx.core.app.ActivityCompat;

public class IvwActivity extends Activity implements OnClickListener{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.ivw_activity);

		SpeechUtility.createUtility(IvwActivity.this, SpeechConstant.APPID+"=5cf85f5a");
		requestPermissions();
		((Button) findViewById(R.id.btn_wake)).setOnClickListener(IvwActivity.this);
		
	}

	@Override
	public void onClick(View v) {
		if( null == VoiceWakeuper.createWakeuper(this, null) ){
			// 创建单例失败，与 21001 错误为同样原因，参考 http://bbs.xfyun.cn/forum.php?mod=viewthread&tid=9688
			Toast.makeText( this
					, "创建对象失败，请确认 libmsc.so 放置正确，\n 且有调用 createUtility 进行初始化"
					, Toast.LENGTH_LONG ).show();
			return;
		}
		
		Intent intent = null;
		switch (v.getId()) {
		case R.id.btn_wake:
			intent = new Intent(IvwActivity.this, WakeActivity.class);
			startActivity(intent);
			break;
		default:
			break;
		}
	}

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

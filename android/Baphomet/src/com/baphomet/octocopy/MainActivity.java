package com.baphomet.octocopy;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends Activity implements OnClickListener {
    /** Called when the activity is first created. */
	
	private EditText query;
	private EditText clip;
	private Button busqueda;
	private Button update;
	
	
	private String url = "http://10.16.104.221:3000/";
	private JSONObject datosJSON;
	private JSONObject octoclip;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
            
        query = (EditText)findViewById(R.id.query);
        busqueda = (Button)findViewById(R.id.busqueda);
        update = (Button)findViewById(R.id.save);
        clip = (EditText)findViewById(R.id.clip);
        
        busqueda.setOnClickListener(this);
        update.setOnClickListener(this);
        
        
    }
    
    //@Override
	public void onClick(View v) {
		//Log.e("onClick","ClickListener is working");			
		switch(v.getId()){
		case R.id.busqueda:
			
			try{
				datosJSON = new JSONObject(lecturaJSON(url+query.getText().toString()+".json"));
				octoclip = datosJSON.getJSONObject("octoclip");
				clip.setText(octoclip.getString("content"));
			}
			catch(JSONException e)        {
				Log.e("log_tag", "Error parsing data "+e.toString());
			}
			
			break;
		
		case R.id.save:
			escribeJSON(query.getText().toString());
			update.setText("Y asi");
			break;
			
		
		}
	}
	
	public String lecturaJSON(String url) {
		StringBuilder builder = new StringBuilder();
		HttpClient client = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(url);
		try {
			HttpResponse response = client.execute(httpGet);
			StatusLine statusLine = response.getStatusLine();
			int statusCode = statusLine.getStatusCode();
			if (statusCode == 200) {
				HttpEntity entity = response.getEntity();
				InputStream content = entity.getContent();
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(content));
				String line;
				while ((line = reader.readLine()) != null) {
					builder.append(line);
				}
			} else {
				//Log.e(ParseJSON.class.toString(), "Failed to download file");
			}
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return builder.toString();
	}
	
	public void escribeJSON(String nombre){
		DefaultHttpClient client = new DefaultHttpClient();

		/** FOR LOCAL DEV   HttpPost post = new HttpPost("http://192.168.0.186:3000/events"); //works with and without "/create" on the end */
		HttpPost post = new HttpPost("http://10.16.104.221:3000/"+nombre+".json");
	    JSONObject holder = new JSONObject();
	    JSONObject datosJSON = new JSONObject();

	    try {	
	    	datosJSON.put("content", clip.getText().toString());
	    	datosJSON.put("url", nombre);
	    	datosJSON.put("id", "16");

		    holder.put("pastebin", datosJSON);

		    Log.e("Pastebin JSON", "Pastebin JSON = "+ holder.toString());

	    	StringEntity se = new StringEntity(datosJSON.toString());
	    	post.setEntity(se);
	    	post.setHeader("Content-Type","application/json");


	    } catch (UnsupportedEncodingException e) {
	    	Log.e("Error",""+e);
	        e.printStackTrace();
	    } catch (JSONException js) {
	    	js.printStackTrace();
	    }

	    HttpResponse response = null;

	    try {
	        response = client.execute(post);
	    } catch (ClientProtocolException e) {
	        e.printStackTrace();
	        Log.e("ClientProtocol",""+e);
	    } catch (IOException e) {
	        e.printStackTrace();
	        Log.e("IO",""+e);
	    }

	    HttpEntity entity = response.getEntity();

	    if (entity != null) {
	        try {
	            entity.consumeContent();
	        } catch (IOException e) {
	        	Log.e("IO E",""+e);
	            e.printStackTrace();
	        }
	    }
	}
	
}
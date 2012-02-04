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
	private EditText nombre;
	private EditText num;
	private EditText numberer;
	private Button busqueda;
	private Button save;
	private String datosJSON;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
            
        query = (EditText)findViewById(R.id.nombre_clip);
        busqueda = (Button)findViewById(R.id.busqueda);
        nombre = (EditText)findViewById(R.id.nombre);
        num = (EditText)findViewById(R.id.num);
        numberer = (EditText)findViewById(R.id.numberer);
        save = (Button)findViewById(R.id.save);
        
        busqueda.setOnClickListener(this);
        save.setOnClickListener(this);
        
        
    }
    
    //@Override
	public void onClick(View v) {
		//Log.e("onClick","ClickListener is working");			
		switch(v.getId()){
		case R.id.busqueda:
			
			datosJSON = lecturaJSON(query.getText().toString());
			nombre.setText(datosJSON);
			break;
		
		case R.id.save:
			escribeJSON();
			break;
			
		
		}
	}
	
	public String lecturaJSON(String nombre) {
		StringBuilder builder = new StringBuilder();
		HttpClient client = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(
				"http://droidrails.herokuapp.com/cosas/"+nombre+".json");
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
	
	public void escribeJSON(){
		DefaultHttpClient client = new DefaultHttpClient();

		/** FOR LOCAL DEV   HttpPost post = new HttpPost("http://192.168.0.186:3000/events"); //works with and without "/create" on the end */
		HttpPost post = new HttpPost("http://droidrails.herokuapp.com/cosas");
	    JSONObject holder = new JSONObject();
	    JSONObject datosJSON = new JSONObject();

	    int iNum = 3;
	    int iNumberer = 33;
	    
	    iNum = Integer.parseInt(num.getText().toString());
	    iNumberer = Integer.parseInt(numberer.getText().toString());

	    try {	
	    	datosJSON.put("nombre", nombre.getText().toString());
	    	datosJSON.put("num", iNum);
	    	datosJSON.put("numberer", iNumberer);

		    holder.put("cosa", datosJSON);

		    Log.e("Event JSON", "Event JSON = "+ holder.toString());

	    	StringEntity se = new StringEntity(holder.toString());
	    	post.setEntity(se);
	    	post.setHeader("Content-Type","application/json");


	    } catch (UnsupportedEncodingException e) {
	    	//Log.e("Error",""+e);
	        e.printStackTrace();
	    } catch (JSONException js) {
	    	js.printStackTrace();
	    }

	    HttpResponse response = null;

	    try {
	        response = client.execute(post);
	    } catch (ClientProtocolException e) {
	        e.printStackTrace();
	        //Log.e("ClientProtocol",""+e);
	    } catch (IOException e) {
	        e.printStackTrace();
	        //Log.e("IO",""+e);
	    }

	    HttpEntity entity = response.getEntity();

	    if (entity != null) {
	        try {
	            entity.consumeContent();
	        } catch (IOException e) {
	        	//Log.e("IO E",""+e);
	            e.printStackTrace();
	        }
	    }
	}
	
}
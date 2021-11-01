package com.example.sentiance_flutter.model;

import org.json.JSONException;
import org.json.JSONObject;

public class SentianceDataModel {

    String userId;
    String sentianceToken;
    String sentianceStatus;

    public SentianceDataModel(String userId, String sentianceStatus, String sentianceToken) {
        this.userId = userId;
        this.sentianceToken = sentianceToken;
        this.sentianceStatus = sentianceStatus;


    }

    public String toJSON() {

        JSONObject jsonObject = new JSONObject();
        try {

            jsonObject.put("userId", userId);
            jsonObject.put("sentianceToken", sentianceToken);
            jsonObject.put("sentianceStatus", sentianceStatus);

            return jsonObject.toString();
        } catch (JSONException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "";
        }

    }

}

package com.example.sentiance_flutter;

import android.content.Context;
import android.content.SharedPreferences;
import androidx.annotation.Nullable;

class Cache {
    private static final String PREF_NAME = "app";
    private static final String KEY_AUTH_TOKEN = "token";
    private static final String KEY_INITIALIZE = "initialize";
    private static final String KEY_APP_SECRET = "app_secret";
    private static final String KEY_APP_ID = "app_id";
    private static final String KEY_USER_LINK_URL = "user_link_url";
    private static final String KEY_MOBILE_HEALTH_URL = "mobile_health_url";
    private static final String KEY_USER_INSTALL_ID = "user_install_id";

    private Context mContext;

    Cache(Context context) {
        mContext = context;
    }

    @Nullable
    String getKeyUserLinkUrl() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_USER_LINK_URL, null);
    }

    void setKeyUserLinkUrl(String url) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_USER_LINK_URL, url).apply();
    }

    @Nullable
    String getMobileHealthUrl() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_MOBILE_HEALTH_URL, null);
    }

    void setMobileHealthUrl(String mobileHealthUrl) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_MOBILE_HEALTH_URL, mobileHealthUrl).apply();
    }
    @Nullable
    String getUserToken() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_AUTH_TOKEN, null);
    }

    void setUserToken(String token) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_AUTH_TOKEN, token).apply();
    }

    @Nullable
    String getInstallId() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_USER_INSTALL_ID, null);
    }

    void setInstallId(String installId) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_USER_INSTALL_ID, installId).apply();
    }

    @Nullable
    String getAppId() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_APP_ID, null);
    }

    void setKeyAppId(String appId) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_APP_ID, appId).apply();
    }

    @Nullable
    String getAppSecret() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_APP_SECRET, null);
    }

    void setAppSecret(String secret) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_APP_SECRET, secret).apply();
    }

    @Nullable
    String getInitialize() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(KEY_INITIALIZE, null);
    }

    void setInitialize(String initialize) {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
        sharedPreferences.edit().putString(KEY_INITIALIZE, initialize).apply();
    }
}


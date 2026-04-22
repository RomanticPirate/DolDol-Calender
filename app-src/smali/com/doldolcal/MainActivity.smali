.class public Lcom/doldolcal/MainActivity;
.super Landroid/app/Activity;

.field private mWebView:Landroid/webkit/WebView;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onResume()V
    .locals 8

    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    iget-object v0, p0, Lcom/doldolcal/MainActivity;->mWebView:Landroid/webkit/WebView;
    if-eqz v0, :_or_end

    :_or_try_s
    invoke-virtual {p0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v1
    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;
    move-result-object v6
    const/4 v7, 0x0
    invoke-virtual {v1, v6, v7}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    move-result-object v1
    iget-wide v2, v1, Landroid/content/pm/PackageInfo;->lastUpdateTime:J

    const-string v1, "app_state"
    const/4 v6, 0x0
    invoke-virtual {p0, v1, v6}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v1

    const-string v6, "last_update_time"
    const-wide/16 v4, 0x0
    invoke-interface {v1, v6, v4, v5}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J
    move-result-wide v4

    cmp-long v6, v2, v4
    if-eqz v6, :_or_unchanged

    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v1
    const-string v6, "last_update_time"
    invoke-interface {v1, v6, v2, v3}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    const-wide/16 v6, 0x0
    cmp-long v1, v4, v6
    if-eqz v1, :_or_unchanged

    const-string v1, "file:///android_asset/index.html"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :_or_unchanged
    :_or_try_e
    .catch Ljava/lang/Exception; {:_or_try_s .. :_or_try_e} :_or_catch

    :_or_end
    return-void

    :_or_catch
    move-exception v0
    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 10

    invoke-super {p0, p1}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V
    invoke-virtual {p0, p1}, Landroid/app/Activity;->setIntent(Landroid/content/Intent;)V

    iget-object v0, p0, Lcom/doldolcal/MainActivity;->mWebView:Landroid/webkit/WebView;
    if-eqz v0, :no_wv

    const-string v1, "open_year"
    const/4 v2, -0x1
    invoke-virtual {p1, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v1
    const-string v3, "open_month"
    invoke-virtual {p1, v3, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v3

    if-eq v1, v2, :no_wv
    if-eq v3, v2, :no_wv

    const-string v6, "open_day"
    invoke-virtual {p1, v6, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v6
    const-string v7, "open_event_id"
    invoke-virtual {p1, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v7

    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "javascript:if(typeof gotoMonth===\'function\'){gotoMonth("
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, ","
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, ","
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, ",\'"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    if-eqz v7, :_eid_empty
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :_eid_empty
    const-string v5, "\')}"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4

    invoke-virtual {v0, v4}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :no_wv
    return-void
.end method

.method public onBackPressed()V
    .locals 2
    iget-object v0, p0, Lcom/doldolcal/MainActivity;->mWebView:Landroid/webkit/WebView;
    if-eqz v0, :cond_0
    const-string v1, "javascript:if(typeof handleAndroidBack===\'function\'){handleAndroidBack()}"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 8

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/doldolcal/MainActivity;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    new-instance v1, Landroid/webkit/WebViewClient;
    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    new-instance v1, Landroid/webkit/WebChromeClient;
    invoke-direct {v1}, Landroid/webkit/WebChromeClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    new-instance v3, Lcom/doldolcal/CalBridge;
    invoke-direct {v3, p0}, Lcom/doldolcal/CalBridge;-><init>(Landroid/content/Context;)V
    const-string v4, "CalBridge"
    invoke-virtual {v0, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v3
    const-string v4, "open_year"
    const/4 v5, -0x1
    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v4
    const-string v6, "open_month"
    invoke-virtual {v3, v6, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5
    const-string v6, "open_day"
    const/4 v7, -0x1
    invoke-virtual {v3, v6, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v6
    const-string v7, "open_event_id"
    invoke-virtual {v3, v7}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v7

    const-string v2, "do_wipe"
    const/4 v1, 0x0
    invoke-virtual {v3, v2, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    move-result v1

    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "file:///android_asset/index.html"
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v2, 0x0
    if-eqz v1, :_no_wipe_q
    const-string v2, "?wipe=1"
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/4 v2, 0x1
    :_no_wipe_q
    # v2 = 1 if wipe param already added (need '&' for next), else 0

    const/4 v1, -0x1
    if-eq v4, v1, :no_ym
    if-eq v5, v1, :no_ym
    if-eqz v2, :_first_q
    const-string v1, "&y="
    goto :_y_pfx
    :_first_q
    const-string v1, "?y="
    :_y_pfx
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v1, "&m="
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const/4 v1, -0x1
    if-eq v6, v1, :no_d
    const-string v1, "&d="
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    :no_d
    if-eqz v7, :no_eid
    const-string v1, "&eid="
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :no_eid
    :no_ym
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    # Start BgListenerService (Foreground Service)
    :_svc_try_s
    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/doldolcal/BgListenerService;
    invoke-direct {v3, p0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v5, 0x1a
    if-lt v4, v5, :_svc_old
    invoke-virtual {p0, v3}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :_svc_done
    :_svc_old
    invoke-virtual {p0, v3}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :_svc_done
    :_svc_try_e
    .catch Ljava/lang/Exception; {:_svc_try_s .. :_svc_try_e} :_svc_catch
    goto :_svc_after
    :_svc_catch
    move-exception v3
    :_svc_after

    return-void
.end method

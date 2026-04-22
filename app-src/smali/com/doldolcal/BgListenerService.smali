.class public Lcom/doldolcal/BgListenerService;
.super Landroid/app/Service;

.field private mWebView:Landroid/webkit/WebView;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Service;-><init>()V
    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 1
    const/4 v0, 0x0
    return-object v0
.end method

.method public onCreate()V
    .locals 5

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    :try_start
    # Create WebView(this)
    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/doldolcal/BgListenerService;->mWebView:Landroid/webkit/WebView;

    # WebSettings
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    # WebViewClient
    new-instance v1, Landroid/webkit/WebViewClient;
    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    # WebChromeClient
    new-instance v1, Landroid/webkit/WebChromeClient;
    invoke-direct {v1}, Landroid/webkit/WebChromeClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V

    # Add CalBridge(this) as "CalBridge"
    new-instance v3, Lcom/doldolcal/CalBridge;
    invoke-direct {v3, p0}, Lcom/doldolcal/CalBridge;-><init>(Landroid/content/Context;)V
    const-string v4, "CalBridge"
    invoke-virtual {v0, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    # Load bg_listener.html
    const-string v1, "file:///android_asset/bg_listener.html"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    :_ret
    return-void

    :catch
    move-exception v0
    goto :_ret
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 7

    :try_start
    # Get NotificationManager
    const-string v0, "notification"
    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/NotificationManager;

    # Create channel (IMPORTANCE_MIN for quiet persistent)
    const-string v1, "doldol_bg"
    const-string v2, "백그라운드 실행"
    const/4 v3, 0x1
    # IMPORTANCE_MIN = 1

    new-instance v4, Landroid/app/NotificationChannel;
    invoke-direct {v4, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
    invoke-virtual {v0, v4}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    # Build notification
    new-instance v2, Landroid/app/Notification$Builder;
    invoke-direct {v2, p0, v1}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const v3, 0x01080077
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    const-string v3, "돌돌 캘린더"
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    const-string v3, "알림 수신 준비 중"
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    # setPriority PRIORITY_MIN = -2
    const/4 v3, -0x2
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    # setOngoing(true)
    const/4 v3, 0x1
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    # setShowWhen(false)
    const/4 v3, 0x0
    invoke-virtual {v2, v3}, Landroid/app/Notification$Builder;->setShowWhen(Z)Landroid/app/Notification$Builder;

    # setContentIntent → MainActivity
    new-instance v5, Landroid/content/Intent;
    const-class v6, Lcom/doldolcal/MainActivity;
    invoke-direct {v5, p0, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const v6, 0x4000000
    const/4 v3, 0x0
    invoke-static {p0, v3, v5, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v5
    invoke-virtual {v2, v5}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    # build()
    invoke-virtual {v2}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v2

    # startForeground(1, notification) — with dataSync type if API 29+
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, 0x1d
    if-lt v3, v4, :_old_fg

    # API 29+: startForeground(id, notif, foregroundServiceType=dataSync=1)
    const/4 v3, 0x1
    const/4 v4, 0x1
    invoke-virtual {p0, v3, v2, v4}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;I)V
    goto :_fg_done

    :_old_fg
    const/4 v3, 0x1
    invoke-virtual {p0, v3, v2}, Landroid/app/Service;->startForeground(ILandroid/app/Notification;)V

    :_fg_done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    :_done
    # return START_STICKY (1)
    const/4 v0, 0x1
    return v0

    :catch
    move-exception v0
    const/4 v0, 0x1
    return v0
.end method

.method public onDestroy()V
    .locals 2

    :try_start
    iget-object v0, p0, Lcom/doldolcal/BgListenerService;->mWebView:Landroid/webkit/WebView;
    if-eqz v0, :_no_wv
    const-string v1, "about:blank"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    invoke-virtual {v0}, Landroid/webkit/WebView;->onPause()V
    invoke-virtual {v0}, Landroid/webkit/WebView;->removeAllViews()V
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    const/4 v0, 0x0
    iput-object v0, p0, Lcom/doldolcal/BgListenerService;->mWebView:Landroid/webkit/WebView;
    :_no_wv
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    :_end
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V
    return-void

    :catch
    move-exception v0
    goto :_end
.end method

.class public Lcom/doldolcal/MainActivity;
.super Landroid/app/Activity;

.field private mWebView:Landroid/webkit/WebView;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 7

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

    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "javascript:if(typeof gotoMonth===\'function\'){gotoMonth("
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, ","
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v5, ")}"
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

    # Build URL with optional ?y=YYYY&m=MM from intent extras
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v3
    const-string v4, "open_year"
    const/4 v5, -0x1
    invoke-virtual {v3, v4, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v4
    const-string v6, "open_month"
    invoke-virtual {v3, v6, v5}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5

    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "file:///android_asset/index.html"
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    const/4 v6, -0x1
    if-eq v4, v6, :no_ym
    if-eq v5, v6, :no_ym
    const-string v6, "?y="
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    const-string v6, "&m="
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    :no_ym
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    return-void
.end method

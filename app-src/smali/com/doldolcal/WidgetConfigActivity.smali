.class public Lcom/doldolcal/WidgetConfigActivity;
.super Landroid/app/Activity;

.field private mWidgetId:I
.field private mWebView:Landroid/webkit/WebView;

.method public constructor <init>()V
    .locals 1
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V
    const/4 v0, 0x0
    iput v0, p0, Lcom/doldolcal/WidgetConfigActivity;->mWidgetId:I
    return-void
.end method

.method public getWidgetId()I
    .locals 1
    iget v0, p0, Lcom/doldolcal/WidgetConfigActivity;->mWidgetId:I
    return v0
.end method

.method public finishWithOk()V
    .locals 3

    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "appWidgetId"
    iget v2, p0, Lcom/doldolcal/WidgetConfigActivity;->mWidgetId:I
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/4 v1, -0x1
    invoke-virtual {p0, v1, v0}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 8

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    # Set initial result to CANCELED so back-press removes the widget
    new-instance v0, Landroid/content/Intent;
    invoke-direct {v0}, Landroid/content/Intent;-><init>()V
    const/4 v1, 0x0
    invoke-virtual {p0, v1, v0}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    # Read appWidgetId from intent
    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;
    move-result-object v0
    const-string v1, "appWidgetId"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v3
    iput v3, p0, Lcom/doldolcal/WidgetConfigActivity;->mWidgetId:I

    # If invalid id, finish
    if-nez v3, :id_ok
    invoke-virtual {p0}, Landroid/app/Activity;->finish()V
    return-void

    :id_ok
    # Build WebView
    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, p0}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v0, p0, Lcom/doldolcal/WidgetConfigActivity;->mWebView:Landroid/webkit/WebView;

    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, 0x1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    new-instance v1, Landroid/webkit/WebViewClient;
    invoke-direct {v1}, Landroid/webkit/WebViewClient;-><init>()V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    new-instance v3, Lcom/doldolcal/WidgetConfigBridge;
    invoke-direct {v3, p0}, Lcom/doldolcal/WidgetConfigBridge;-><init>(Lcom/doldolcal/WidgetConfigActivity;)V
    const-string v4, "WidgetCfg"
    invoke-virtual {v0, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v3, "file:///android_asset/widget_config.html"
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    return-void
.end method

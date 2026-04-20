.class public Lcom/doldolcal/WidgetConfigBridge;
.super Ljava/lang/Object;

.field private mActivity:Lcom/doldolcal/WidgetConfigActivity;

.method public constructor <init>(Lcom/doldolcal/WidgetConfigActivity;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;
    return-void
.end method

.method private getPrefs()Landroid/content/SharedPreferences;
    .locals 3
    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;
    const-string v1, "widget_prefs"
    const/4 v2, 0x0
    invoke-virtual {v0, v1, v2}, Lcom/doldolcal/WidgetConfigActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    return-object v0
.end method

.method public getWidgetId()Ljava/lang/String;
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;
    invoke-virtual {v0}, Lcom/doldolcal/WidgetConfigActivity;->getWidgetId()I
    move-result v0
    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v1
    return-object v1
.end method

.method public getStyle(I)Ljava/lang/String;
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-direct {p0}, Lcom/doldolcal/WidgetConfigBridge;->getPrefs()Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "style_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    const-string v2, "white"
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    return-object v3
.end method

.method public getOpacity(I)I
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-direct {p0}, Lcom/doldolcal/WidgetConfigBridge;->getPrefs()Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "opacity_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    const/16 v2, 0x64
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I
    move-result v3
    return v3
.end method

.method public getFontSize(I)Ljava/lang/String;
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-direct {p0}, Lcom/doldolcal/WidgetConfigBridge;->getPrefs()Landroid/content/SharedPreferences;
    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "fontsize_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1

    const-string v2, "normal"
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    return-object v3
.end method

.method public save(ILjava/lang/String;ILjava/lang/String;)V
    .locals 6
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-direct {p0}, Lcom/doldolcal/WidgetConfigBridge;->getPrefs()Landroid/content/SharedPreferences;
    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0

    # style_<id>
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "style_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    # opacity_<id>
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "opacity_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1, p3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    # fontsize_<id>
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "fontsize_"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1, p4}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    # Trigger widget update broadcast
    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;

    new-instance v1, Landroid/content/Intent;
    const-string v2, "android.appwidget.action.APPWIDGET_UPDATE"
    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    new-instance v2, Landroid/content/ComponentName;
    const-class v3, Lcom/doldolcal/CalWidgetProvider;
    invoke-direct {v2, v0, v3}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {v1, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    const/4 v3, 0x1
    new-array v4, v3, [I
    const/4 v5, 0x0
    aput p1, v4, v5
    const-string v5, "appWidgetIds"
    invoke-virtual {v1, v5, v4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[I)Landroid/content/Intent;

    invoke-virtual {v0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V

    # Run finishWithOk on UI thread
    new-instance v1, Lcom/doldolcal/WidgetConfigBridge$1;
    invoke-direct {v1, p0}, Lcom/doldolcal/WidgetConfigBridge$1;-><init>(Lcom/doldolcal/WidgetConfigBridge;)V
    invoke-virtual {v0, v1}, Lcom/doldolcal/WidgetConfigActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public cancel()V
    .locals 2
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;
    new-instance v1, Lcom/doldolcal/WidgetConfigBridge$2;
    invoke-direct {v1, p0}, Lcom/doldolcal/WidgetConfigBridge$2;-><init>(Lcom/doldolcal/WidgetConfigBridge;)V
    invoke-virtual {v0, v1}, Lcom/doldolcal/WidgetConfigActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void
.end method

# Accessor for inner classes
.method public getActivity()Lcom/doldolcal/WidgetConfigActivity;
    .locals 1
    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge;->mActivity:Lcom/doldolcal/WidgetConfigActivity;
    return-object v0
.end method

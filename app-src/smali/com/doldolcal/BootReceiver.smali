.class public Lcom/doldolcal/BootReceiver;
.super Landroid/content/BroadcastReceiver;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

# Starts BgListenerService on boot or after app update (MY_PACKAGE_REPLACED).
# BOOT_COMPLETED and MY_PACKAGE_REPLACED are exempt from background FGS restrictions.
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 4

    :try_start
    # Intent for BgListenerService
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/doldolcal/BgListenerService;
    invoke-direct {v0, p1, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    # API 26+ → startForegroundService, else startService
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v2, 0x1a
    if-lt v1, v2, :_old_svc
    invoke-virtual {p1, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :_svc_done
    :_old_svc
    invoke-virtual {p1, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :_svc_done

    # Log which action triggered us
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v0
    const-string v1, "doldolBoot"
    if-nez v0, :_has_act
    const-string v0, "(null action)"
    :_has_act
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :_catch

    return-void

    :_catch
    move-exception v0
    return-void
.end method

.class public Lcom/doldolcal/AlarmReceiver;
.super Landroid/content/BroadcastReceiver;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 10
    # p0=this, p1=context, p2=intent
    # v0~v6 available

    :try_start

    # v0 = title string
    const-string v0, "alarm_title"
    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-nez v0, :has_t
    const-string v0, "\ub3cc\ub3cc \uce98\ub9b0\ub354"
    :has_t

    # v1 = message string
    const-string v1, "alarm_message"
    invoke-virtual {p2, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-nez v1, :has_m
    const-string v1, ""
    :has_m

    # v2 = NotificationManager
    const-string v2, "notification"
    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/app/NotificationManager;

    # Create NotificationChannel
    # constructor: (String id, CharSequence name, int importance)
    const-string v3, "doldol_alarm"
    const-string v4, "\uc54c\ub9bc"
    const/4 v5, 0x4

    new-instance v6, Landroid/app/NotificationChannel;
    invoke-direct {v6, v3, v4, v5}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    const/4 v5, 0x1
    invoke-virtual {v6, v5}, Landroid/app/NotificationChannel;->enableVibration(Z)V
    invoke-virtual {v2, v6}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    # Build Notification
    # v3 still = "doldol_alarm" (channel id)
    new-instance v4, Landroid/app/Notification$Builder;
    invoke-direct {v4, p1, v3}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    # setSmallIcon
    const v5, 0x01080077
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    # setContentTitle
    invoke-virtual {v4, v0}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    # setContentText
    invoke-virtual {v4, v1}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    # setAutoCancel(true)
    const/4 v5, 0x1
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setAutoCancel(Z)Landroid/app/Notification$Builder;

    # setPriority HIGH
    const/4 v5, 0x1
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setPriority(I)Landroid/app/Notification$Builder;

    # setContentIntent → open app
    new-instance v5, Landroid/content/Intent;
    const-class v6, Lcom/doldolcal/MainActivity;
    invoke-direct {v5, p1, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const v6, 0x4000000
    const/4 v3, 0x0
    invoke-static {p1, v3, v5, v6}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v5
    invoke-virtual {v4, v5}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;

    # build() and notify
    invoke-virtual {v4}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v4
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v5
    long-to-int v5, v5
    invoke-virtual {v2, v5, v4}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    # Vibrate
    const-string v2, "vibrator"
    invoke-virtual {p1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/os/Vibrator;
    if-eqz v2, :done
    const-wide/16 v3, 0x12c
    invoke-virtual {v2, v3, v4}, Landroid/os/Vibrator;->vibrate(J)V

    :done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch

    return-void

    :catch
    move-exception v0
    return-void
.end method

.class public Lcom/doldolcal/CalBridge;
.super Ljava/lang/Object;

.field private mContext:Landroid/content/Context;

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/CalBridge;->mContext:Landroid/content/Context;
    return-void
.end method

# Schedule alarm at exact epoch millis. Called from JS when saving event.
# p1=requestCode(int), p2=triggerAtMillis(long as string), p3=title, p4=message
.method public scheduleAlarm(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start
    iget-object v0, p0, Lcom/doldolcal/CalBridge;->mContext:Landroid/content/Context;

    # Parse trigger time
    invoke-static {p2}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J
    move-result-wide v1

    # Create intent for AlarmReceiver
    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/doldolcal/AlarmReceiver;
    invoke-direct {v3, v0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    # Set action to ensure unique intent
    const-string v4, "com.doldolcal.ALARM"
    invoke-virtual {v3, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    # Set unique data URI per requestCode (PendingIntent 캐시 충돌 방지)
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "doldol://alarm/"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v4
    invoke-virtual {v3, v4}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const-string v4, "alarm_title"
    invoke-virtual {v3, v4, p3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v4, "alarm_message"
    invoke-virtual {v3, v4, p4}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    # PendingIntent with FLAG_UPDATE_CURRENT | FLAG_IMMUTABLE
    const v4, 0xC000000
    invoke-static {v0, p1, v3, v4}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v3

    # Get AlarmManager
    const-string v4, "alarm"
    invoke-virtual {v0, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/app/AlarmManager;

    # API 31+ (Android 12+): canScheduleExactAlarms 체크
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v6, 0x1f
    if-lt v5, v6, :do_exact

    invoke-virtual {v4}, Landroid/app/AlarmManager;->canScheduleExactAlarms()Z
    move-result v5
    if-nez v5, :do_exact

    # 정확한 알람 권한 없으면 일반 알람으로 (오차 허용)
    const/4 v5, 0x0
    invoke-virtual {v4, v5, v1, v2, v3}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V
    goto :alarm_done

    :do_exact
    const/4 v5, 0x0
    invoke-virtual {v4, v5, v1, v2, v3}, Landroid/app/AlarmManager;->setExactAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    :alarm_done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    return-void

    :catch
    move-exception v0
    return-void
.end method

# Cancel a scheduled alarm by requestCode
.method public cancelAlarm(I)V
    .locals 4
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start
    iget-object v0, p0, Lcom/doldolcal/CalBridge;->mContext:Landroid/content/Context;

    new-instance v1, Landroid/content/Intent;
    const-class v2, Lcom/doldolcal/AlarmReceiver;
    invoke-direct {v1, v0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const v2, 0xC000000
    invoke-static {v0, p1, v1, v2}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v1

    const-string v2, "alarm"
    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/app/AlarmManager;

    invoke-virtual {v2, v1}, Landroid/app/AlarmManager;->cancel(Landroid/app/PendingIntent;)V

    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    return-void

    :catch
    move-exception v0
    return-void
.end method

# Test alarm (5 sec delay) — 배포 시 제거
.method public testAlarm(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 7
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start
    iget-object v0, p0, Lcom/doldolcal/CalBridge;->mContext:Landroid/content/Context;

    # trigger = now + delay
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v1
    int-to-long v3, p3
    add-long/2addr v1, v3

    # Create intent (with unique data to avoid PendingIntent caching)
    new-instance v3, Landroid/content/Intent;
    const-class v4, Lcom/doldolcal/AlarmReceiver;
    invoke-direct {v3, v0, v4}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v4, "com.doldolcal.ALARM"
    invoke-virtual {v3, v4}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    # Unique URI per call (timestamp 사용)
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "doldol://test/"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    invoke-virtual {v4, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v4
    invoke-virtual {v3, v4}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    const-string v4, "alarm_title"
    invoke-virtual {v3, v4, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v4, "alarm_message"
    invoke-virtual {v3, v4, p2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    # Use timestamp as requestCode (unique each time)
    long-to-int v4, v1
    const v5, 0xC000000
    invoke-static {v0, v4, v3, v5}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v3

    # AlarmManager
    const-string v4, "alarm"
    invoke-virtual {v0, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/app/AlarmManager;

    # Check exact alarm permission (API 31+)
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v6, 0x1f
    if-lt v5, v6, :test_exact

    invoke-virtual {v4}, Landroid/app/AlarmManager;->canScheduleExactAlarms()Z
    move-result v5
    if-nez v5, :test_exact

    const/4 v0, 0x0
    invoke-virtual {v4, v0, v1, v2, v3}, Landroid/app/AlarmManager;->setAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V
    goto :test_done

    :test_exact
    const/4 v0, 0x0
    invoke-virtual {v4, v0, v1, v2, v3}, Landroid/app/AlarmManager;->setExactAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    :test_done
    :try_end
    .catch Ljava/lang/Exception; {:try_start .. :try_end} :catch
    return-void

    :catch
    move-exception v0
    return-void
.end method

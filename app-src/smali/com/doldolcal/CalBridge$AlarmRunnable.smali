.class Lcom/doldolcal/CalBridge$AlarmRunnable;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field private bridge:Lcom/doldolcal/CalBridge;
.field private title:Ljava/lang/String;
.field private message:Ljava/lang/String;

.method constructor <init>(Lcom/doldolcal/CalBridge;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    iput-object p1, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->bridge:Lcom/doldolcal/CalBridge;
    iput-object p2, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->title:Ljava/lang/String;
    iput-object p3, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->message:Ljava/lang/String;
    return-void
.end method

.method public run()V
    .locals 2
    iget-object v0, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->bridge:Lcom/doldolcal/CalBridge;
    iget-object v1, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->title:Ljava/lang/String;
    iget-object p0, p0, Lcom/doldolcal/CalBridge$AlarmRunnable;->message:Ljava/lang/String;
    invoke-virtual {v0, v1, p0}, Lcom/doldolcal/CalBridge;->showNotification(Ljava/lang/String;Ljava/lang/String;)V
    return-void
.end method

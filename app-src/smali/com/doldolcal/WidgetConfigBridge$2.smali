.class Lcom/doldolcal/WidgetConfigBridge$2;
.super Ljava/lang/Object;
.implements Ljava/lang/Runnable;

.field final synthetic this$0:Lcom/doldolcal/WidgetConfigBridge;

.method constructor <init>(Lcom/doldolcal/WidgetConfigBridge;)V
    .locals 0
    iput-object p1, p0, Lcom/doldolcal/WidgetConfigBridge$2;->this$0:Lcom/doldolcal/WidgetConfigBridge;
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V
    return-void
.end method

.method public run()V
    .locals 2
    iget-object v0, p0, Lcom/doldolcal/WidgetConfigBridge$2;->this$0:Lcom/doldolcal/WidgetConfigBridge;
    invoke-virtual {v0}, Lcom/doldolcal/WidgetConfigBridge;->getActivity()Lcom/doldolcal/WidgetConfigActivity;
    move-result-object v1
    invoke-virtual {v1}, Landroid/app/Activity;->finish()V
    return-void
.end method

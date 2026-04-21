.class public Lcom/doldolcal/CalEventService;
.super Landroid/widget/RemoteViewsService;

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Landroid/widget/RemoteViewsService;-><init>()V
    return-void
.end method

.method public onGetViewFactory(Landroid/content/Intent;)Landroid/widget/RemoteViewsService$RemoteViewsFactory;
    .locals 1
    new-instance v0, Lcom/doldolcal/CalEventFactory;
    invoke-direct {v0, p0, p1}, Lcom/doldolcal/CalEventFactory;-><init>(Landroid/content/Context;Landroid/content/Intent;)V
    return-object v0
.end method

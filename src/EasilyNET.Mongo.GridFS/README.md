##### 如何使用?

- 在系统环境变量或者 Docker 容器中设置环境变量名称为: CONNECTIONSTRINGS_MONGO = mongodb 链接字符串 或者在
  appsetting.json 中添加,
- 现在你也可以参考 Test 项目查看直接传入相关数据.

```json
{
  "ConnectionStrings": {
    "Mongo": "mongodb链接字符串"
  },
  // 或者使用
  "CONNECTIONSTRINGS_MONGO": "mongodb链接字符串"
}
```

##### 使用 EasilyNET.Mongo.GridFS

- 使用 Nuget 安装 EasilyNET.Mongo.GridFS
- .Net 6 +

```csharp
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

// 添加Mongodb数据库服务
builder.Services.AddMongoContext<EasilyNETMongoContext>(builder.Configuration);
// 添加GridFS服务
builder.Services.AddEasilyNETGridFS(fsOptions: c =>
{
    c.BusinessApp = "easilyfs";
    c.Options = new()
    {
        BucketName = "easilyfs",
        ChunkSizeBytes = 1024,
        DisableMD5 = true,
        ReadConcern = new() { },
        ReadPreference = ReadPreference.Primary,
        WriteConcern = WriteConcern.Unacknowledged
    };
    c.DefaultDB = true;
    c.ItemInfo = "item.info";
});
...

var app = builder.Build();
```
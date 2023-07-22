using System.Text;
using Google.Api.Gax.ResourceNames;
using Google.Cloud.SecretManager.V1;
using Google.Protobuf;

namespace api.Domain.Secret;

public class GoogleSecretService : ISecretService
{

    public string GetSecret(string secretId)
    {
        var client = SecretManagerServiceClient.Create();

        var projectName = new ProjectName(Environment.GetEnvironmentVariable("GOOGLE_PROJECT_ID"));

        var secret = new Google.Cloud.SecretManager.V1.Secret
        {
            Replication = new Replication
            {
                Automatic = new Replication.Types.Automatic(),
            },
        };

        var createdSecret = client.CreateSecret(projectName, secretId, secret);

        var payload = new SecretPayload
        {
            Data = ByteString.CopyFrom("", Encoding.UTF8),
        };
        
        var createdVersion = client.AddSecretVersion(createdSecret.SecretName, payload);
        
        var result = client.AccessSecretVersion(createdVersion.SecretVersionName);

        return result.Payload.Data.ToStringUtf8();
    }
    
}
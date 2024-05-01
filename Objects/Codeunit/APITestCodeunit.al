codeunit 50100 APITestCodeunit
{
    var
        AccessKeySetup: Record "Access Key Setup";
        AccessKey: Text;
        AccessKeyRead: Boolean;
        APIResponseMessage: Label 'Status Code : %1\Reason : %2';

    procedure IsValidPhoneNumber(PhoneNumber: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonManagement: Codeunit "JSON Management";
        Response: Text;
        ResultVariant: Variant;
    begin
        GetAccessKey();
        if HttpClient.Get('https://apilayer.net/api/validate?access_key=' + AccessKey + '&number=' + PhoneNumber + '&country_code=&format=1',
            HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(Response);
            JsonManagement.InitializeObject(Response);
            JsonManagement.GetPropertyValueByName('valid', ResultVariant);
            exit(ResultVariant.IsBoolean());
        end else
            Message(APIResponseMessage, HttpResponseMessage.HttpStatusCode, HttpResponseMessage.ReasonPhrase);
    end;

    procedure GetCatFact(): Text
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        Url: Label 'https://cat-fact.herokuapp.com/facts/random?animal_type=cat&amount=1', Locked = true;
        Response: Text;
        JsonManagement: Codeunit "JSON Management";
        ResultVariant: Variant;
    begin
        if HttpClient.Get(Url, HttpResponseMessage) then begin
            HttpResponseMessage.Content.ReadAs(Response);
            JsonManagement.InitializeObject(Response);
            JsonManagement.GetPropertyValueByName('text', ResultVariant);
            exit(Format(ResultVariant));
        end else
            Message(APIResponseMessage, HttpResponseMessage.HttpStatusCode, HttpResponseMessage.ReasonPhrase);
    end;

    local procedure GetAccessKey()
    begin
        if AccessKeyRead then
            exit;

        AccessKeySetup.Get();
        AccessKeyRead := true;
        AccessKey := AccessKeySetup."Access Key";
    end;
}

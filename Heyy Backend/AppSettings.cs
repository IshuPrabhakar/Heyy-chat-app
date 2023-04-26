public class AppSettings
{
    public ConnectionString? ConnectionString { get; set; }
    public JWT? JWT { get; set; }
    public string? EncyptKey { get; set; }
    public EmailSetting? EmailSetting { get; set; }

    public FcmConfig? FcmConfig { get; set; }
}

public class JWT
{
    public string? Issuer { get; set; }
    public string? Audience { get; set; }
}

public class ConnectionString
{
    public string? RemoteDB { get; set; }
    public string? LocalDB { get; set; }

    public string? LocalDB2 { get; set; }
}

public class EmailSetting
{
    public string? Username { get; set; }
    public string? Host { get; set; }
    public string? Password { get; set; }
}

public class FcmConfig
{
    public string? SenderId { get; set; }
    public string? SenderKey { get; set; }
}
namespace Dtos;

public class SearchRequest
{
    public string? Email { get; set; }
    public string? Mobile { get; set; }
    public string? Name { get; set; }
    public string? Username { get; set; }
}

public class SearchResponse
{
    public string? Name { get; set; }
    public string? ProfilePhotoUrl { get; set; }
}


public class SearchContactRequest
{
    public string? DisplayName { get; set; }
    public List<Item>? Phones { get; set; }
}

public class SearchContactResponse
{
    public int Id { get; set; } = 0;
    public string? Name { get; set; }
    public string? profilePic { get; set; }
    public string? UUID { get; set; }
    public string? DeviceId { get; set; }
    public int? IsRegisterd { get; set; }
    public string? Mobile { get; set; }
    public string? Email { get; set; }
    public string? Bio { get; set; }
    public string? Profession { get; set; }

}




public class Item
{
    public string? Label { get; set; }
    public string? Value { get; set; }
}

public enum PhoneLabel
{
    assistant,
    callback,
    car,
    companyMain,
    faxHome,
    faxOther,
    faxWork,
    home,
    iPhone,
    isdn,
    main,
    mms,
    mobile,
    pager,
    radio,
    school,
    telex,
    ttyTtd,
    work,
    workMobile,
    workPager,
    other,
    custom,
}
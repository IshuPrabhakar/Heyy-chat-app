namespace Services.Mapper;

public static class ObjectMapper<T1, T2> where T1 : class where T2 : class
{
    public static T2 Map(T1 src, T2 des)
    {
        foreach (var prop in src.GetType().GetProperties())
        {
            var Value = prop.GetValue(src);
            var Name = prop.Name;
            if (Value is not null && des.GetType().GetProperty(Name) is not null)
            {
                des.GetType().GetProperty(Name)!.SetValue(des, Value, null);
            }
        }
        return des;
    }
}
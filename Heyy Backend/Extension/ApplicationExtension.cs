public static class ApplicationExtension
{
    /// <summary>
    /// Hooks every api class extending [IModule] to the application 
    /// </summary>
    /// <param name="app"></param>
    public static void MapEndpoint(this WebApplication app)
    {
        var assemblies = AppDomain.CurrentDomain.GetAssemblies();
        var classes = assemblies.Distinct().SelectMany(x => x.GetTypes())
        .Where(x => typeof(IModule).IsAssignableFrom(x) && !x.IsInterface && !x.IsAbstract);

        foreach (var c in classes)
        {
            var instance = Activator.CreateInstance(c) as IModule;
            instance?.MapEndpoints(app);
        }
    }
}
[assembly: WebActivator.PostApplicationStartMethod(typeof(Sample.Web.MVC.App_Start.SimpleInjectorInitializer), "Initialize")]

namespace Sample.Web.MVC.App_Start
{
    using Sample.Domain;
    using Sample.Repository.Interface;
    using SimpleInjector;
    using SimpleInjector.Integration.Web.Mvc;
    using System.Reflection;
    using System.Web.Mvc;

    public static class SimpleInjectorInitializer
    {
        /// <summary>Initialize the container and register it as MVC3 Dependency Resolver.</summary>
        public static void Initialize()
        {
            // Did you know the container can diagnose your configuration? Go to: http://bit.ly/YE8OJj.
            var container = new Container();

            InitializeContainer(container);

            container.RegisterMvcControllers(Assembly.GetExecutingAssembly());

            container.RegisterMvcAttributeFilterProvider();

            container.Verify();

            DependencyResolver.SetResolver(new SimpleInjectorDependencyResolver(container));
        }

        private static void InitializeContainer(Container container)
        {
            // Register Type for Repository

            string repositoryType = MvcApplication.RepositoryType;

            container.Register
            (
                typeof(IEmployeeRepository),
                ReflectionHelper.GetType(repositoryType, string.Concat(repositoryType, ".EmployeeRepository"))
            );
        }
    }
}
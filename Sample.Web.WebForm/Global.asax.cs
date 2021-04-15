using Sample.Domain;
using Sample.Repository.Interface;
using SimpleInjector;
using StackExchange.Profiling;
using StackExchange.Profiling.Storage;
using System;
using System.Web;
using System.Web.Configuration;
using System.Web.Optimization;
using System.Web.Routing;

namespace Sample.Web.WebForm
{
    public class Global : HttpApplication
    {
        public static string RepositoryType
        {
            get
            {
                return WebConfigurationManager.AppSettings["RepositoryType"].ToString();
            }
        }

        private void Application_Start(object sender, EventArgs e)
        {
            // 應用程式啟動時執行的程式碼
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            // Simple Injector
            SimpleInjectorBootstrap();

            // MiniProfiler
            InitProfilerSettings();
        }

        private void Application_End(object sender, EventArgs e)
        {
            //  應用程式關閉時執行的程式碼
        }

        private void Application_Error(object sender, EventArgs e)
        {
            // 發生未處理錯誤時執行的程式碼
        }

        protected void Application_BeginRequest()
        {
            MiniProfiler profiler = null;
            // might want to decide here (or maybe inside the action) whether you want
            // to profile this request - for example, using an "IsSystemAdmin" flag against
            // the user, or similar; this could also all be done in action filters, but this
            // is simple and practical; just return null for most users. For our test, we'll
            // profile only for local requests (seems reasonable)
            if (Request.IsLocal)
            {
                //profiler = MiniProfiler.Start();
                profiler = MiniProfiler.StartNew();
            }
        }

        protected void Application_EndRequest()
        {
            //MiniProfiler.Stop();

            if (MiniProfiler.Current != null)
            {
                MiniProfiler.Current.Stop();
            }
        }

        #region -- Simple Injector Bootstrap --

        private static Container container;

        [System.Diagnostics.DebuggerStepThrough]
        public static TService GetInstance<TService>()
            where TService : class
        {
            return container.GetInstance<TService>();
        }

        private void SimpleInjectorBootstrap()
        {
            //=====================================================================================
            // 1. Create a new Simple Injector container
            var container = new Container();

            //=====================================================================================
            // 2. Get Repository Assembly Name

            string repositoryType = WebConfigurationManager.AppSettings["RepositoryType"].ToString().Trim();

            //=====================================================================================
            // 3. Register Type for Repository

            string repositoryAssemblyName = repositoryType;
            string classFullName = string.Concat(repositoryType, ".CategoryRepository");

            //這邊加入類別的註冊
            container.Register
            (
                typeof(IEmployeeRepository),
                ReflectionHelper.GetType(repositoryType, string.Concat(repositoryType, ".EmployeeRepository"))
            );

            //=====================================================================================
            // 4. Store the container for use by Page classes.

            container.Verify();
            Global.container = container;
        }

        #endregion -- Simple Injector Bootstrap --

        #region -- MiniProfiler Init Settings --

        //private void InitProfilerSettings()
        //{
        //    // some things should never be seen
        //    var ignored = MiniProfiler.Settings.IgnoredPaths.ToList();
        //    ignored.Add("WebResource.axd");
        //    ignored.Add("/Styles/");
        //    ignored.Add("/bundles/");
        //    MiniProfiler.Settings.IgnoredPaths = ignored.ToArray();
        //    MiniProfiler.Settings.SqlFormatter = new StackExchange.Profiling.SqlFormatters.InlineFormatter();
        //    MiniProfilerEF.Initialize();
        //}

        /// <summary>
        /// Gets or sets a value indicating whether disable profiling results.
        /// </summary>
        public static bool DisableProfilingResults { get; set; }

        private void InitProfilerSettings()
        {
            MiniProfilerOptions MiniProfilerOptions = new MiniProfilerOptions
            {
                Storage = new MultiStorageProvider(new MemoryCacheStorage(new TimeSpan(1, 0, 0))),

                PopupRenderPosition = RenderPosition.Left,  // defaults to left
                PopupMaxTracesToShow = 10,                   // defaults to 15

                ResultsAuthorize = request =>
                {
                    if ("/home/resultsauthorization".Equals(request.Url.LocalPath, StringComparison.OrdinalIgnoreCase))
                    {
                        return (request.Url.Query).IndexOf("isauthorized", StringComparison.OrdinalIgnoreCase) >= 0;
                    }

                    return !DisableProfilingResults;
                },

                ResultsListAuthorize = request =>
                {
                    return true;
                },

                StackMaxLength = 256,
                TrackConnectionOpenClose = true
            }

            .ExcludeType("SessionFactory")
            .ExcludeAssembly("NHibernate")
            .ExcludeMethod("Flush");

            MiniProfilerOptions.IgnorePath("/__browserLink");//Ignore browserLink
            MiniProfilerOptions.ShowControls = true; // "m" and "c" are displayed on the prompt bar
            MiniProfiler.Configure(MiniProfilerOptions);

            MiniProfilerEF.Initialize();
        }

        #endregion -- MiniProfiler Init Settings --
    }
}
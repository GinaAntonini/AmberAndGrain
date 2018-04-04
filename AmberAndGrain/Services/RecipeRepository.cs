using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AmberAndGrain.Models;
using Dapper;

namespace AmberAndGrain.Services
{
    public class RecipeRepository
    {
        public bool Create(RecipeDTO recipe)
        {
            using (var db = new SqlConnection(ConfigurationManager.ConnectionStrings["AmberAndGrain"].ConnectionString))
            {
                db.Open();
                var numberCreated = db.Execute(@"INSERT INTO [dbo].[Recipes]
                           ([Name]
                           ,[PercentWheat]
                           ,[PercentCorn]
                           ,[BarrelAge]
                           ,[BarrelMaterial]
                           ,[Creator])
                         VALUES
                           (@Name
                           ,@PercentWheat
                           ,@PercentCorn
                           ,@BarrelAge
                           ,@BarrelMaterial
                           ,@Creator)", recipe);
                return numberCreated == 1;
            }
        }
    }
}
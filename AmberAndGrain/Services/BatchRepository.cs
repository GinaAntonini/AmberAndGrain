using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Dapper;

namespace AmberAndGrain.Services
{
    public class BatchRepository
    {
        public bool Create(int recipeId, string cooker)
        {
            using (var db = new SqlConnection(ConfigurationManager.ConnectionStrings["AmberAndGrain"].ConnectionString))
            {
                db.Open();
                var batchesCreated = db.Execute(@"INSERT INTO Batches (RecipeId, Cooker)
                            VALUES (@recipeId, @cooker)", new { recipeId, cooker });

                return batchesCreated == 1;
            }
        }
    }
}
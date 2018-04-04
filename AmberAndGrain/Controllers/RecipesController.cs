using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AmberAndGrain.Models;
using AmberAndGrain.Services;

namespace AmberAndGrain.Controllers
{
    [RoutePrefix("api/recipes")]
    public class RecipesController : ApiController
    {
        [Route(""), HttpPost]
        public HttpResponseMessage AddRecipe (RecipeDTO recipe)
        {
            var repository = new RecipeRepository();
            var result = repository.Create(recipe);
            if (result)
            {
                return Request.CreateResponse(HttpStatusCode.Created);
            }

            return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Could not create Recipe. Please try again");
        }
    }

}

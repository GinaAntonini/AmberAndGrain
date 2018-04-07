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
    [RoutePrefix("api/batches")]
    public class BatchesController : ApiController
    {
        [Route, HttpPost]
        public HttpResponseMessage AddBatch(AddBatchDto addBatch)
        {
            var repository = new BatchRepository();
            var result = repository.Create(addBatch.RecipeId, addBatch.Cooker);

            if (result)
            {
                return Request.CreateResponse(HttpStatusCode.Created);
            }

            return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "no it not work");
        }
    }
}

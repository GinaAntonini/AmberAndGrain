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

        [Route("{batchId}/mash"), HttpPatch]
        public HttpResponseMessage MashBatch(int batchId)
        {
            var repository = new BatchRepository();
            Batch batch;

            try
            {
                batch = repository.Get(batchId);

            }
            catch (Exception)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, "batchId does not exist");
            }
            if (batch.Status == BatchStatus.Created) 
            {
                batch.Status = BatchStatus.Mashed;
                var result = repository.Update(batch);
                return result ? Request.CreateResponse(HttpStatusCode.OK) : Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "u suk");
            }

            return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "U suk");
        }
    }
}

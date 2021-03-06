﻿using System;
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

            return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "Sorry about your luck, batch");
        }

        [Route("{batchId}/mash"), HttpPatch]
        public HttpResponseMessage MashBatch(int batchId)
        {
            var batchMasher = new BatchMasher();
            var mashMe = batchMasher.MashBatch(batchId);

            switch (mashMe)
            {
                case UpdateStatusResults.NotFound:
                    return Request.CreateErrorResponse(HttpStatusCode.NotFound, "batchId does not exist");
                case UpdateStatusResults.Unsuccessful:
                    return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, "I suk");
                case UpdateStatusResults.Success:
                    return Request.CreateResponse(HttpStatusCode.OK);
                case UpdateStatusResults.ValidationFailure:
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "U suk");
                default:
                    return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Nathan Sucks");
            }
        }



    }
}
using AutoMapper;
using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;

namespace src.Application.Endpoint.Search;

public static class Search
{
    public static IResult Handle([FromBody] SearchRequest request, AppDbContext dbContext)
    {
        var mappingConfig = new MapperConfiguration(cfg => cfg.CreateMap<User, SearchResponse>());
        var mapper = new Mapper(mappingConfig);

        if (request.Email is not null)
        {
            var result = dbContext.User.Where(u => u.Email == request.Email).Select(x => x).FirstOrDefault();
            return Results.Ok(mapper.Map<SearchResponse>(result));
        }
        else if (request.Mobile is not null)
        {
            var result = dbContext.User.Where(u => u.Mobile == request.Mobile).Select(x => x).FirstOrDefault();
            return Results.Ok(mapper.Map<SearchResponse>(result));
        }
        else
        {
            var result = dbContext.User.Where(u => u.Name == request.Name).Select(x => x).FirstOrDefault();
            return Results.Ok(mapper.Map<SearchResponse>(result));
        }
    }
}
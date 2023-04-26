using System.Linq;
using AutoMapper;
using Db;
using Dtos;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace src.Application.Endpoint.Search;

public static class SearchContacts
{
    public static IResult Handle([FromBody] List<SearchContactRequest> request, AppDbContext dbContext)
    {
        var reqToResConfig = new MapperConfiguration(cfg => cfg.CreateMap<SearchContactRequest, SearchContactResponse>()
        .ForMember(x => x.Name, opt => opt.MapFrom(y => y.DisplayName))
        .ForMember(x => x.Mobile, opt => opt.MapFrom(y => y.Phones!.Select(y => y.Value).FirstOrDefault())));
        var mapper = new Mapper(reqToResConfig);
        var response = mapper.Map<List<SearchContactResponse>>(request);

        // marking all users unregisterd first
        response.ForEach(r => r.IsRegisterd = 0);

        var phone = request.SelectMany(x => x.Phones!).Select(y => y.Value).ToList();
        var contacts = dbContext.User.Where(e => phone.Contains(e.Mobile!)).Select(u => u).ToList();

        // Mapping User and SearchContactResponse
        var mappingConfig = new MapperConfiguration(cfg => cfg.CreateMap<User, SearchContactResponse>()
                            .ForMember(dest => dest.profilePic, opt => opt.MapFrom(src => src.ProfilePhotoUrl)));
        mapper = new Mapper(mappingConfig);
        var dbres = mapper.Map<List<SearchContactResponse>>(contacts);
        dbres.ForEach(r => r.IsRegisterd = 1);

        response.AddRange(dbres);

        return Results.Ok(response.Distinct().ToList());
    }
}
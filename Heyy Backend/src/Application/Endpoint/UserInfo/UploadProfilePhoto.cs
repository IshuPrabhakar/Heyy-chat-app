using Db;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace src.Application.Endpoint.UserInfo;

public static class UploadProfilePhoto
{
    public static async Task<IResult> Handle(IFormFile file, HttpRequest request, AppDbContext dbContext)
    {
        string uuid = string.Empty;
        if (request is not null && !String.IsNullOrEmpty(request.Cookies["userid"]))
            uuid = request.Cookies["userid"]!;
        else
            return Results.BadRequest("Cookies not found.");

        var dbObj = dbContext.User.Where(u => u.UUID == uuid).Select(x => x).FirstOrDefault();

        if (dbObj is not null)
        {
            try
            {
                var _fileExtension = new DirectoryInfo(file!.FileName);
                var _fileDirectory = Path.Combine(Directory.GetCurrentDirectory(), "Uploads", dbObj.Name!);

                Directory.CreateDirectory(_fileDirectory);
                var filepath = Path.Combine(_fileDirectory, $"{dbObj.Name!}{_fileExtension.Extension}");

                using var stream = File.OpenWrite(filepath);
                await file.CopyToAsync(stream);

                // update filepath in db
                dbObj.ProfilePhotoUrl = filepath;
                dbContext.Entry(dbObj).CurrentValues.SetValues(dbObj);
                var result = await dbContext.SaveChangesAsync();

                return Results.Ok();
            }
            catch (System.Exception e)
            {
                return Results.BadRequest(e);
            }
        }

        return Results.BadRequest("User not found");
    }
}

using Db;
using Serilog;
using Microsoft.EntityFrameworkCore;
using src.Application.Services.EmailService;
using src.Application.Services.JwtService;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;
using Microsoft.AspNetCore.HttpOverrides;
using System.Net;
using src.Application.Hubs.RtcHubs;
using MessagePack;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

// Cors
builder.Services.AddCors();
builder.Services.AddHttpsRedirection(opt =>
{
    opt.RedirectStatusCode = (int)HttpStatusCode.TemporaryRedirect;
    opt.HttpsPort = 5001;
});

builder.Services.AddSignalR(opt =>
{
    opt.EnableDetailedErrors = true;
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(opt =>
{
    //opt.SwaggerDoc("v1.0", new OpenApiInfo { Title = "Heyy database & auth server", Version = "v1.0"});
    opt.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
    {
        Description = "Standard Authorization using jwt bearer",
        In = ParameterLocation.Header,
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,
        BearerFormat = "jwt",
        Scheme = "bearer"
    });
    //opt.OperationFilter<SecurityRequirementsOperationFilter>();
});
builder.Services.Configure<AppSettings>(builder.Configuration.GetSection("AppSettings"));
builder.Services.AddAutoMapper(typeof(Program));

builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IJwtService, JwtService>();

// DbContext
// Local db 
builder.Services.AddDbContext<AppDbContext>(
    opt => opt.UseSqlServer(builder.Configuration["AppSettings:ConnectionString:LocalDB2"])
);
// RemoteDb
// builder.Services.AddDbContext<AppDbContext>(
//     opt => opt.UseMySQL(builder.Configuration["AppSettings:ConnectionString:RemoteDB"])
// );

// Serilog Configuration
builder.Host.UseSerilog((context, config) =>
{
    config.WriteTo.Console().MinimumLevel.Information();
    //config.ReadFrom.Configuration(context.Configuration);
});

// JWT
builder.Services.AddAuthentication(opt =>
{
    opt.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    opt.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    opt.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(opt =>
{
    opt.SaveToken = true;
    opt.RequireHttpsMetadata = false;
    opt.TokenValidationParameters = new TokenValidationParameters()
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidAudience = builder.Configuration["AppSettings:JWT:Audience"],
        ValidIssuer = builder.Configuration["AppSettings:JWT:Issuer"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["AppSettings:EncyptKey"]!)),
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true
    };
});

builder.Services.AddAuthorization(
    opt =>
    {
        opt.AddPolicy("user", policy => policy.RequireRole("user"));
        opt.AddPolicy("admin", policy => policy.RequireRole("admin"));
    }
);

var app = builder.Build();

// Configure the HTTP request pipeline.
// if (app.Environment.IsDevelopment())
// {
app.UseSwagger();
app.UseSwaggerUI();
// }

app.UseHsts();

app.UseSerilogRequestLogging();
app.UseHttpsRedirection();

app.UseCors((opt =>
    opt.AllowAnyHeader()
    .AllowAnyMethod()
    .AllowAnyOrigin()
));

app.UseAuthentication();
app.UseAuthorization();

// add api endpoints here
app.MapEndpoint();


app.Run();


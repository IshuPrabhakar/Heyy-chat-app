using Dtos;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using Serilog;

namespace src.Application.Hubs.RtcHubs;


public class MessageHub : Hub
{
    /// <summary>
    /// Create A group imidiatialy when the user connect.
    /// </summary>
    /// <param name="UserId"></param>
    /// <returns></returns>
    public async Task OnConnect(string UserId)
    {
        await Groups.AddToGroupAsync(Context.ConnectionId, UserId);
        Log.Information($"Context id: {Context.ConnectionId} with userid: {UserId} connected..");
    }

    public async Task SendOffer(string senderId, string offer, List<string> connections)
    {
        await Clients.Groups(connections).SendAsync("OnOfferRecieve", senderId, offer);
        Log.Information($"offer sent");
    }

    public async Task SendAnswer(string toUserId, string answer)
    {
        await Clients.Groups(toUserId).SendAsync("OnAnswerRecieve", answer);
        Log.Information($"Answer sent");
    }

    public async Task ChatRequestResponse(string response)
    {
        ChatRequestResponse? res = JsonConvert.DeserializeObject<ChatRequestResponse>(response);
        await Clients.Groups(res!.recieverUserId!).SendAsync("OnChatRequestResponse", JsonConvert.SerializeObject(res));
    }

    /// <summary> 
    /// Removes a group imidiatialy when the user disconnect.
    /// </summary>
    /// <param name="UserId"></param>
    /// <returns></returns>
    public async Task OnDisconnect(string UserId)
    => await Groups.RemoveFromGroupAsync(Context.ConnectionId, UserId);

    /// <summary>
    /// Send messages from peer to peer
    /// </summary>
    /// <param name="message"></param>
    /// <returns></returns>
    public async Task SendMessage(string json)
    {
        MessageDto? msg = JsonConvert.DeserializeObject<MessageDto>(json);
        await Clients.Group(msg!.reciverUserId!).SendAsync("RecieveMessage", JsonConvert.SerializeObject(msg));
    }

    /// <summary>
    /// Notifies users about chat request 
    /// </summary>
    /// <param name="UserId"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task SendChatRequestNotification(string json)
    {
        ChatRequestNotification? noti = JsonConvert.DeserializeObject<ChatRequestNotification>(json);
        await Clients.Group(noti!.recieverUserId!).SendAsync("RecieveChatRequestNotification", JsonConvert.SerializeObject(noti));
    }

    /// <summary>
    /// Notifies users wheather a user isTyping, online or offline
    /// </summary>
    /// <param name="UserId"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task UserActiveStatus(string status)
    {
        await Clients.Others.SendAsync("RecieveActiveStatus", status);
    }


    /// <summary>
    /// Notifies users wheather a user isTyping or not.
    /// </summary>
    /// <param name="UserId"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task UserTypingStatus(string UserId, string status)
    => await Clients.Group(UserId).SendAsync("RecieveTypingStatus", status);

    /// <summary>
    /// Notifies users wheather has been deliverd, sent or seen
    /// </summary>
    /// <param name="UserId"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task MessageStatus(string UserId, string status)
    => await Clients.Group(UserId).SendAsync("RecieveMessageStatus", status);

}
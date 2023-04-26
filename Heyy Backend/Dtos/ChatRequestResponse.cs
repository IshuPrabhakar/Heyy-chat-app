namespace Dtos;

class ChatRequestResponse
{
    public string? senderRoomId { get; set; }
    public string? senderUserId { get; set; }
    public string? recieverUserId { get; set; }
    public string? recieverRoomId { get; set; }
}
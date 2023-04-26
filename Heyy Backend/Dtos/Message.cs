namespace Dtos;

public class MessageDto
{

    public int id { get; set; }
    public string? deviceId { get; set; }
    public string? reciverUserId { get; set; }
    public string? reciverRoomId { get; set; }
    public string? senderUserId { get; set; }
    public string? senderRoomId { get; set; }
    public DateTime sentTime { get; set; }
    public string? message { get; set; }
    public string? rtcData { get; set; }
    public int isMe { get; set; }
    public string? type { get; set; }
    public int isSeen { get; set; }
    public int isReplied { get; set; }
    public int isForwarded { get; set; }
    public int isDeleted { get; set; }
    public int isReacted { get; set; }
    public RepliedTo? repliedTo { get; set; }
    public ForwardedFrom? forwardedFrom { get; set; }
    public DeletedFor? deletedFor { get; set; }
    public List<MessageReaction>? reactions { get; set; }
}

public class ForwardedFrom
{
    public string? UserId { get; set; }
    public string? ChatroomId { get; set; }
    public int? MessageId { get; set; }
}

public class MessageReaction
{
    public string? UserId { get; set; }
    public string? Reaction { get; set; }
}

public class DeletedFor
{
    public string? UserId { get; set; }
}

public class RepliedTo
{
    public int? MessageId { get; set; }
    public string? UserId { get; set; }
}

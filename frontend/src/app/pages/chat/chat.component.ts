import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { BodyMessage } from 'src/app/core/models/message';
import { ChatService } from 'src/app/core/services/chat.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit {
  message: string = '';
  sender!: string;
  bodyMessage!: BodyMessage;
  received: BodyMessage[] = [];

  // Access the message input field for focus on
  @ViewChild('messageInput') messageInput!: ElementRef;

  constructor(
    private chatService: ChatService,
    private route: ActivatedRoute
  ) {}

  ngOnInit(): void {
    // Retrieve the sender name from the URL parameter
    this.sender = this.route.snapshot.params['user'];
    // Subscribe to the messages Observable
    this.chatService.getMessages().subscribe((message) => {
      this.received.push(JSON.parse(message))
    })
  }

  ngAfterViewInit(): void {
    setTimeout(() => {
      this.messageInput.nativeElement.focus()
    })
  }

  // Send a message and clear the input field
  send() {
    this.bodyMessage = {
      content: this.message,
      sender: this.sender
    }
    this.chatService.sendMessage(this.bodyMessage);
    this.message = ''
  }
}

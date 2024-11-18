import { Injectable } from '@angular/core';
import { Client, Message } from '@stomp/stompjs';
import { Observable, Subject } from 'rxjs';
import { BodyMessage } from 'src/app/core/models/message';
import * as SockJS from 'sockjs-client';

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  private client: Client;
  private wsEndpoint: string = 'http://localhost:8080/chat-websocket'
  private destination: string = '/app/chat/Room1';
  private url: string = '/topic/Room1';
  private messageSubject: Subject<string> = new Subject<string>();

  constructor() {
    // Initialize STOMP client with WebSocket endpoint
    this.client = new Client({
      webSocketFactory: () => new SockJS(this.wsEndpoint)
    });

    // Connecting the STOMP Client
    this.client.onConnect = () => {
      // Subscribe to a topic and emit the income messages in the Subject
      this.client.subscribe(this.url, (message: Message) => {
        this.messageSubject.next(message.body);
      });
    };
    this.client.activate();
  }

  // Return an Observable for received messages
  getMessages(): Observable<string> {
    return this.messageSubject.asObservable();
  }

  // Send a chat message to a specific destination
  sendMessage(bodyMessage: BodyMessage): void {
    const destination = this.destination
    this.client.publish({ destination, body: JSON.stringify(bodyMessage) })
  }
}

import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import mongoose, { Document } from 'mongoose';
import { Content } from '../contents/contents.schema';
import { Policy } from '../policies/policies.schema';

export type ArticleDocument = Article & Document;

@Schema({
  timestamps: { createdAt: 'created', updatedAt: 'updated' },
})
export class Article {
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  description: string;

  @Prop({ required: true })
  views: number;

  @Prop({ required: true })
  likes: number;

  @Prop({ required: true })
  image: string;

  @Prop({ required: true })
  author: string;

  @Prop()
  coAuthor: string;

  @Prop()
  language: string;

  @Prop({ type: [{ type: mongoose.Schema.Types.ObjectId, ref: Content.name }] })
  contents: mongoose.Schema.Types.ObjectId[];
}

export const ArticleSchema = SchemaFactory.createForClass(Article);
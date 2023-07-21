import {
    IsNotEmpty,
    IsString,
    IsNumber,
    MaxLength,
    MinLength,
    IsArray,
  } from 'class-validator';
import { Content } from 'src/apis/contents/contents.schema';
  
export class CreateArticleDto {
    @IsString()
    @IsNotEmpty()
    @MinLength(5)
    title: string;
  
    @IsString()
    @IsNotEmpty()
    @MinLength(5)
    @MaxLength(500)
    description: string;
  
    @IsNumber()
    @IsNotEmpty()
    views: number;

    @IsNumber()
    @IsNotEmpty()
    likes: number;

    @IsString()
    @IsNotEmpty()
    image: string;

    @IsString()
    @IsNotEmpty()
    author: string;

    @IsString()
    coAuthor: string;

    @IsString()
    language: string;

    @IsArray()
    contents: Content[];
}
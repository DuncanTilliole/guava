import {
    IsNotEmpty,
    IsString,
    IsNumber,
    MaxLength,
    MinLength,
  } from 'class-validator';
  
export class UpdateArticleDto {
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
    author: string;

    @IsString()
    coAuthor: string;

    @IsString()
    language: string;

    @IsString()
    @IsNotEmpty()
    image: string;
}
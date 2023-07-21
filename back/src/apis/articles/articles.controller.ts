import { Controller, Get, Post, Body, Headers, Patch, Param, Delete, StreamableFile } from '@nestjs/common';
import { createReadStream } from 'fs';
import { join } from 'path';
import { guavaResponse } from 'src/genericModels/response.model';
import { ArticleDocument } from './articles.schema';
import { ArticlesService } from './articles.service';
import { CreateArticleDto } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';

@Controller('articles')
export class ArticlesController {
  constructor(private readonly articlesService: ArticlesService) {}

  @Post()
  create(@Body() createArticleDto: CreateArticleDto): Promise<ArticleDocument> {
    return this.articlesService.create(createArticleDto);
  }

  @Get()
  findAll(@Headers('sort') sort: string | null, @Headers('language') language: string): Promise<ArticleDocument[]> {
    return this.articlesService.findAll(sort, language);
  }

  @Get(':id')
  findOne(@Param('id') id: string): Promise<ArticleDocument> {
    return this.articlesService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateArticleDto: UpdateArticleDto): Promise<ArticleDocument> {
    return this.articlesService.update(id, updateArticleDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string): Promise<guavaResponse> {
    return this.articlesService.remove(id);
  }
}
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateArticleDto } from './dto/create-article.dto';
import { UpdateArticleDto } from './dto/update-article.dto';
import { Article, ArticleDocument } from './articles.schema';
import { Content, ContentDocument } from '../contents/contents.schema';
import { guavaResponse } from 'src/genericModels/response.model';

@Injectable()
export class ArticlesService {
  constructor(
    @InjectModel(Article.name) private readonly articlesModel: Model<ArticleDocument>,
    @InjectModel(Content.name) private readonly contentsModel: Model<ContentDocument>,
  ) {}

  async create(createArticleDto: CreateArticleDto): Promise<ArticleDocument> {
    const { contents, ...articleToSave } = createArticleDto
    // Register all contents who are related to the article
    const contentsSaved = await Promise.all(createArticleDto.contents.map((content) => {
      const contentSave = new this.contentsModel(content)
      return contentSave.save();
    }))
    // Register the article
    const article = new this.articlesModel({ ...articleToSave, contents: contentsSaved.map(({id}) => id)});
    await article.save();
    // Return the article and its contents
    return this.articlesModel.findById(article._id).populate('contents');
  }

  async findAll(sort: string | null, language: string): Promise<ArticleDocument[]> {
    let query = this.articlesModel.find();
    // If a langugage is not equal to '', add the filter language
    if (language !== '') {
      query = query.where({ language: language });
    }
    // If sort exist, add the sort filter
    if (sort) {
      const jsonFilter = JSON.parse(sort);
      query = query.sort(jsonFilter);
    }
    return query.exec();
  }

  async findOne(id: string) {
    const article = await this.articlesModel.findById(id)
    const newArticle = await this.articlesModel
      .findByIdAndUpdate(id, { views: article.views + 1 })
      .setOptions({ new: true })
      .populate('contents');
    return newArticle;
  }

  async update(id: string, updateArticleDto: UpdateArticleDto): Promise<ArticleDocument> {
    const article = await this.articlesModel
      .findByIdAndUpdate(id, updateArticleDto)
      .setOptions({ new: true })
    
    if (!article) {
      throw new NotFoundException();
    }
    return article;
  }

  async remove(id: string): Promise<guavaResponse> {
    const articleToRemove = await this.articlesModel.findById(id);
    await this.contentsModel.deleteMany({ _id: articleToRemove.contents});
    await this.articlesModel.findByIdAndRemove(id);
    return { success: true, action: 'delete'};
  }
}
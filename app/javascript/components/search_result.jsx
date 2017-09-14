import React from 'react'
import ReactDOM from 'react-dom'
import Article from '../components/article'

export default class SearchResult extends React.Component {

  render() {
    let articles = this.props.articles.map((article) => {
      return (
        <Article key={article.id} article={article} />
      )
    })
    return (
      <div className="search_results" > { articles }
        <div className="clear"></div>
      </div>
    )
  }
}


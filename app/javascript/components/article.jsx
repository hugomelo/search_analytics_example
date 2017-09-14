import React from 'react'
import ReactDOM from 'react-dom'

export default class Article extends React.Component {
  render() {
    return (
      <div className="article">
        {this.props.article.title}
      </div>
    )
  }
}



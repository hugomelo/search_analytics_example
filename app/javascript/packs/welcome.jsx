import React from 'react'
import ReactDOM from 'react-dom'
import SearchBar from '../components/search_bar'
import SearchResult from '../components/search_result'
import Analytics from '../components/analytics'
var crypto = require('crypto')

// this is the main component which controls the sub-components
// The states are usually lifted up here to share states
class Welcome extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      articles: []
    }
    this.searchToken = crypto.randomBytes(25).toString('hex');
    this.handleSearchInputChange = this.handleSearchInputChange.bind(this);
  }
  handleSearchInputChange(text) {
    if (text.trim() == "") {
      this.setState({articles: []})
      return
    }
    this.searchText = text
    setTimeout(this.fetchArticles.bind(this,text), 400)
  }

  // Avoid fetching new articles on every new char typed by user
  // Wait for the user to stop typing before requesting it
  fetchArticles(text) {
    if (text != this.searchText) return;

    fetch("/api/search.json", {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        q: text,
        token: this.searchToken
      })
    }).then( (response) => {
      return response.json() })
      .then( (json) => {
        this.setState(json)
      })
  }

  render() {
    return (
      <div>
        <SearchBar onInput={this.handleSearchInputChange} />
        <div className="results box">
          <h2>Search Results</h2>
          <SearchResult articles={this.state.articles} />
        </div>
        <div className="analytics box">
          <h2>Search Analytics</h2>
          <Analytics />
        </div>
      </div>
    )
  }
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Welcome />,
    document.body.appendChild(document.getElementById('welcome')),
  )
})



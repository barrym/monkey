// Place your application-specific JavaScript functions and classes here
// This file is wlly included by javascript_include_tag :defaults

Event.observe(document, 'dom:loaded', function() {
  Event.observe('post_subject', 'focus', function() {
    showNewPostForm();
  });

  setUpNewPostCategories();

});

function setUpNewPostCategories() {
  var categoryList = new Hash();

  $F('category_ids').split(', ').each(function(e) {
    if(e != '')
    {
      categoryList.set(e, 1);
    }
  })

  $$('.to_category').each(function(e) {
    Event.observe(e, 'click', function() {

      this.toggleClassName('selected');

      if(categoryList.get(this.readAttribute('category_id')) != undefined)
      {
        categoryList.unset(this.readAttribute('category_id'));
      }
      else
      {
        categoryList.set(this.readAttribute('category_id'), 1);
      }
      $('category_ids').value = categoryList.keys().sort().join(",");
    })
  })

}

function showNewPostForm() {
  if(!$('new_post_body').visible()) {
    Effect.BlindDown('new_post_body', { duration: 0.3 });
    Effect.BlindDown('new_post_categories', { duration: 0.3 });
    Effect.BlindDown('new_post_submit', { duration: 0.3 });
    $('post_subject').clear();
  }
}

function hideNewPostForm() {
  if($('new_post_body').visible()) {
    Effect.BlindUp('new_post_body', { duration: 0.3 });
    Effect.BlindUp('new_post_categories', { duration: 0.3 });
    Effect.BlindUp('new_post_submit', { duration: 0.3 });
  }
}

function clearNewPostForm() {
  if($('new_post_body').visible()) {
    $('post_body').clear();
    $('post_subject').value = "Click here to post";
    hideNewPostForm();
  }
}

function showCommentForm(dom_id, body) {
  body = (body || "");
  $(dom_id + '_comment_body').value = body;
  $(dom_id + '_comment').show();
  $(dom_id + '_comment_body').focus();
}

function hideCommentForm(dom_id) {
  $(dom_id + '_comment').hide();
}

function displayNewComment(entity_dom_id, comment_dom_id, content) {
  if($(entity_dom_id + '_comments')) {
    Element.insert(entity_dom_id + '_comments', {bottom: content});
    // Effect.SlideDown(comment_dom_id, {duration: 0.5});
    $(comment_dom_id).highlight();
    reRenderComments(entity_dom_id);
  }
}

function reRenderComments(entity_dom_id) {
  if($(entity_dom_id + '_comments')) {
    console.log("here");
    comments = $$('#' + entity_dom_id + '_comments div.comment');
    console.debug(comments);
    console.log(comments.size());
  }
}

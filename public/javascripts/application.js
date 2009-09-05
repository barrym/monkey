// Place your application-specific JavaScript functions and classes here
// This file is wlly included by javascript_include_tag :defaults

$j(document).ready(function() {
  $j('#post_subject').focus( function() {
    showNewPostForm();
    });
  $j('#new_post_form').ajaxForm(clearNewPostForm);
});

function showNewPostForm() {
  if($j('#new_post_body').is(':hidden')) {
    $j('#new_post_body').slideDown(300);
    $j('#new_post_categories').slideDown(300);
    $j('#new_post_submit').slideDown(300);
    $j('#post_subject').val('');
  }
}

function hideNewPostForm() {
  if($j('#new_post_body').is(':visible')) {
    $j('#new_post_body').slideUp(300);
    $j('#new_post_categories').slideUp(300);
    $j('#new_post_submit').slideUp(300);
  }
}

function clearNewPostForm() {
  if($j('#new_post_body').is(':visible')) {
    $j('#post_body').val('');
    $j('#post_subject').val('Click here to post');
    hideNewPostForm();
  }
}

function showCommentForm(dom_id, body) {
  body = (body || "");
  $j('#' + dom_id + '_comment_body').val(body);
  $j('#' + dom_id + '_comment').show();
  $j('#' + dom_id + '_comment_body').focus();
}

function hideCommentForm(dom_id) {
  $j('#' + dom_id + '_comment').hide();
}

function displayNewPost(post_id) {
  $j('#spinner').show();
  jQuery.getScript('/posts/' + post_id + '/display', function(data) {
    $j('#spinner').hide();
  });
}

function displayNewComment(entity_dom_id, comment_id) {
  // TODO : fix this shit
  // if comments are here, add a new one
  if($j(entity_dom_id + '_comments')) {
    $j('#spinner').show();
    $j.getScript('/comments/' + comment_id + '/display', function() {
      $j('#spinner').hide();
    });
  } else {
    // TODO : if the entity is here (ie classic mode)
    // then call posts/X/update_display
    // which rerenders that partial with an updated comment/like count
  }
}









/* not in use */



// function displayNewComment(entity_dom_id, comment_dom_id, content) {
  // if($(entity_dom_id + '_comments')) {
  //   Element.insert(entity_dom_id + '_comments', {bottom: content});
  //   // Effect.SlideDown(comment_dom_id, {duration: 0.5});
  //   $(comment_dom_id).highlight();
  //   reRenderComments(entity_dom_id);
  // }
// }

// function reRenderComments(entity_dom_id) {
//   if($(entity_dom_id + '_comments')) {
//     console.log("here");
//     comments = $$('#' + entity_dom_id + '_comments div.comment');
//     console.debug(comments);
//     console.log(comments.size());
//   }
// }

/**
 * default.js
 * Everything that's needed to add some dynamic functionality to our project.
 *
 * @author Nathan Campos <nathan@innoveworkshop.com>
 */

"use strict";

/**
 * Confirms with the user and deletes a post by its ID and refreshes the page.
 *
 * @param postID ID of the post to be deleted.
 */
function deletePost(postID) {
	// Confirm with the user if we should delete this post.
	if (!confirm("Do you wish to delete post #" + postID + "?"))
		return;
	
	// Delete the post.
	window.location.href += "&delete=" + postID;
}

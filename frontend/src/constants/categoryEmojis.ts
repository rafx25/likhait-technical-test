/**
 * Emoji mappings for expense categories.
 *
 * Keys cover the seeded categories. Any category without a specific mapping
 * (e.g. a custom one created by the user) falls back to a neutral tag icon.
 */

const DEFAULT_EMOJI = "🏷️";

export const CATEGORY_EMOJIS: Record<string, string> = {
  Food: "🍔",
  Transportation: "🚗",
  Entertainment: "🎬",
  Shopping: "🛍️",
  Bills: "📄",
  Healthcare: "🏥",
  Education: "📚",
  Travel: "✈️",
  Personal: "🧍",
  Other: "📦",
};

export function getCategoryEmoji(category: string): string {
  return CATEGORY_EMOJIS[category] || DEFAULT_EMOJI;
}

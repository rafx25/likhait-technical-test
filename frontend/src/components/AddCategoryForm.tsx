/**
 * Form component for creating a new expense category
 */

import React, { useState } from "react";
import { TextField, Button } from "../vibes";

interface AddCategoryFormProps {
  onSubmit: (name: string) => Promise<void>;
  onCancel?: () => void;
}

export function AddCategoryForm({ onSubmit, onCancel }: AddCategoryFormProps) {
  const [name, setName] = useState("");
  const [error, setError] = useState<string | undefined>();
  const [isSubmitting, setIsSubmitting] = useState(false);

  const formStyle: React.CSSProperties = {
    display: "flex",
    flexDirection: "column",
    gap: "1rem",
  };

  const buttonGroupStyle: React.CSSProperties = {
    display: "flex",
    gap: "0.5rem",
    marginTop: "0.5rem",
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!name.trim()) {
      setError("Category name is required");
      return;
    }

    setIsSubmitting(true);
    try {
      await onSubmit(name.trim());
      // Reset on success
      setName("");
      setError(undefined);
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to create category",
      );
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} style={formStyle}>
      <TextField
        label="Category Name"
        type="text"
        placeholder="e.g. Groceries"
        value={name}
        onChange={(e) => {
          setName(e.target.value);
          if (error) setError(undefined);
        }}
        error={error}
        fullWidth
        required
      />

      <div style={buttonGroupStyle}>
        <Button
          type="submit"
          variant="primary"
          disabled={isSubmitting}
          fullWidth
        >
          {isSubmitting ? "Adding..." : "Add Category"}
        </Button>
        {onCancel && (
          <Button
            type="button"
            variant="secondary"
            onClick={onCancel}
            disabled={isSubmitting}
          >
            Cancel
          </Button>
        )}
      </div>
    </form>
  );
}

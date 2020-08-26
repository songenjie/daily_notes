MergingParams



```c++
    /// Parameters for various modes.
    struct MergingParams
    {
        /// Merging mode. See above.
        enum Mode
        {
            Ordinary            = 0,    /// Enum values are saved. Do not change them.
            Collapsing          = 1,
            Summing             = 2,
            Aggregating         = 3,
            Replacing           = 5,
            Graphite            = 6,
            VersionedCollapsing = 7,
        };

        Mode mode;

        /// For Collapsing and VersionedCollapsing mode.
        String sign_column;

        /// For Summing mode. If empty - columns_to_sum is determined automatically.
        Names columns_to_sum;

        /// For Replacing and VersionedCollapsing mode. Can be empty for Replacing.
        String version_column;

        /// For Graphite mode.
        Graphite::Params graphite_params;

        /// Check that needed columns are present and have correct types.
        void check(const NamesAndTypesList & columns) const;

        String getModeName() const;
    };
```





MergeTreeData {



}
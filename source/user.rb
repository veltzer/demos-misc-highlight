Code:Puppet::Functions.create_function(:<FUNCTION NAME>) do
      dispatch :<METHOD NAME> do
          param '<DATA TYPE>', :<ARGUMENT NAME (displayed in docs/errors)>
              ...
      end

      def <METHOD NAME>(<ARGUMENT NAME (for local use)>, ...)
            <IMPLEMENTATION>
      end
end
